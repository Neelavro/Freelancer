import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/app_static_values.dart';
import 'package:xilancer/customizations.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/models/project_details_model.dart';
import 'package:xilancer/services/create_project_service.dart';
import 'package:xilancer/views/onboarding_view/onboarding_view.dart';

import '../../models/category_model.dart';
import '../../models/packages_model.dart';

class CreateProjectViewModel {
  ValueNotifier<double> currentIndex = ValueNotifier(0);
  ValueNotifier<int> currentPackageIndex = ValueNotifier(0);
  TextEditingController skillController = TextEditingController();
  ValueNotifier<File?> projectImage = ValueNotifier(null);
  String? oldImage;
  dynamic id;
  ValueNotifier<bool> multiplePackages = ValueNotifier(false);
  ValueNotifier<List<SubCategory>> selectedSubcategories = ValueNotifier([]);
  ValueNotifier<Category?> selectedCategory = ValueNotifier(null);

  final GlobalKey<FlutterSummernoteState> keyEditor =
      GlobalKey(debugLabel: DateTime.now().millisecondsSinceEpoch.toString());

  ValueNotifier<List<ExtraField>> extraFields = ValueNotifier([]);
  ValueNotifier<String> slugExample = ValueNotifier(siteLink);
  ValueNotifier<List<Package>> packages = ValueNotifier([
    Package(
        name: LocalKeys.basic,
        revision: 4,
        deliveryTime: jobLengths.first,
        regularPrice: 10,
        discountPrice: 9,
        extraFields: []),
    Package(
        name: LocalKeys.standard,
        revision: 4,
        deliveryTime: jobLengths.first,
        regularPrice: 10,
        discountPrice: 9,
        extraFields: []),
    Package(
        name: LocalKeys.premium,
        revision: 4,
        deliveryTime: jobLengths.first,
        regularPrice: 10,
        discountPrice: 9,
        extraFields: []),
  ]);

  TextEditingController titleController = TextEditingController();
  TextEditingController slugController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController packageNameController = TextEditingController();
  TextEditingController regularPriceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();
  List timelineList = [
    LocalKeys.projectIntro,
    LocalKeys.projectGalleryUpload,
    LocalKeys.projectPackagesAndCharge,
  ];
  List timelineDescriptions = [
    LocalKeys.projectIntroDesc,
    LocalKeys.projectGalleryUploadDesc,
    LocalKeys.projectPackagesAndChargeDesc,
  ];

  PageController pageController = PageController(initialPage: 0);

  final GlobalKey<FormState> introFormKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey();

  ValueNotifier packageEditingIndex = ValueNotifier(0);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  CreateProjectViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  CreateProjectViewModel._init();
  static CreateProjectViewModel? _instance;
  static CreateProjectViewModel get instance {
    _instance ??= CreateProjectViewModel._init();
    return _instance!;
  }

  bool get introValidate {
    if (introFormKey.currentState?.validate() != true) {
      return false;
    }
    if (selectedCategory.value == null) {
      LocalKeys.selectAState.showToast();
      return false;
    }
    if (selectedSubcategories.value.isEmpty) {
      LocalKeys.selectSubcategory.showToast();
      return false;
    }
    return true;
  }

  bool get packagesValidate {
    bool isValid = true;
    for (var field in extraFields.value) {
      if (isValid) {
        isValid = field.name.isNotEmpty;
      }
    }
    return isValid;
  }

  void nextPage(BuildContext context) async {
    switch (currentIndex.value.round()) {
      case 0:
        final etEditor = await keyEditor.currentState?.getText();
        debugPrint((etEditor).toString());
        if (etEditor == null) {
          return;
        }
        descriptionController.text = etEditor;
        if (descriptionController.text.length < 50) {
          LocalKeys.writeADescriptionAboutYourProject.showToast();
          return;
        }
        if (introValidate) {
          await pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
          currentIndex.value = pageController.page ?? 0.0;
        } else {
          return;
        }
        break;
      case 1:
        if ((projectImage.value ?? oldImage) == null) {
          LocalKeys.selectPhoto.showToast();
          return;
        }
        await pageController.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        currentIndex.value = pageController.page ?? 0.0;
        break;
      case 2:
        if (!packagesValidate) {
          return;
        }
        isLoading.value = true;
        if (id == null) {
          await Provider.of<CreateProjectService>(context, listen: false)
              .tryCreatingProject()
              .then((v) {
            if (v == true) {
              LocalKeys.projectCreatedSuccessfully.showToast();
              context.toUntilPage(const OnboardingView());
            }
          });
        } else {
          await Provider.of<CreateProjectService>(context, listen: false)
              .tryEditingProject()
              .then((v) {
            if (v == true) {
              LocalKeys.projectCreatedSuccessfully.showToast();
              context.toUntilPage(const OnboardingView());
            }
          });
        }

        isLoading.value = false;
      default:
        final packages;
    }
  }

  List get packageAttributes {
    var attributes = {};

    return attributes.values.toList();
  }

  void goBack() async {
    await pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    currentIndex.value = pageController.page ?? 0.0;
  }

  void selectImage() async {
    try {
      PickedFile? file = await ImagePicker.platform.pickImage(
          source: ImageSource.gallery, maxHeight: 1920, maxWidth: 1080);
      if (file == null) {
        return;
      }
      projectImage.value = File(file.path);
      LocalKeys.fileSelected.showToast();
    } catch (error) {
      LocalKeys.fileSelectFailed.showToast();
    }
  }

  void setSelectedSectionIndex(value) {
    currentIndex.value = value;
    currentIndex.notifyListeners();
  }

  addPackage() {
    packages.value.add(
      Package(
          name: LocalKeys.package,
          revision: 1,
          deliveryTime: jobLengths.firstOrNull ?? "",
          regularPrice: 12,
          discountPrice: 32,
          extraFields: []),
    );
    packages.notifyListeners();
  }

  addField({index}) {
    int id = DateTime.now().millisecondsSinceEpoch;
    extraFields.value.add(ExtraField(
      id: id,
      name: "${LocalKeys.title} ${extraFields.value.length}",
      type: FieldType.CHECK,
    ));
    packages.notifyListeners();
  }

  removeField({index, id}) {
    extraFields.value.removeWhere((element) => element.id == id);
    packages.notifyListeners();
  }

  void setCurrentIndex(int index) {
    currentPackageIndex.value = index;
  }

  void changePackageDelTime(String? value) {}

  bool checkboxValue(ExtraField extraField) {
    switch (currentPackageIndex.value) {
      case 0:
        return extraField.basicValue == "on";
      case 1:
        return extraField.standardValue == "on";
      default:
        return extraField.premiumValue == "on";
    }
  }

  void setCheckBoxValue(ExtraField extraField, {value}) {
    int index = 0;
    index =
        extraFields.value.indexWhere((element) => element.id == extraField.id);
    switch (currentPackageIndex.value) {
      case 0:
        extraFields.value[index] =
            extraField.copyWith(basicValue: value.toString());
      case 1:
        extraFields.value[index] =
            extraField.copyWith(standardValue: value.toString());
      default:
        extraFields.value[index] =
            extraField.copyWith(premiumValue: value.toString());
    }
    debugPrint("value is $value".toString());
    extraFields.notifyListeners();
  }

  num quantityValue(ExtraField extraField) {
    switch (currentPackageIndex.value) {
      case 0:
        return extraField.basicValue.tryToParse;
      case 1:
        return extraField.standardValue.tryToParse;
      default:
        return extraField.premiumValue.tryToParse;
    }
  }

  void setQuantityValue(ExtraField extraField, {value}) {
    int index = 0;
    index =
        extraFields.value.indexWhere((element) => element.id == extraField.id);
    switch (currentPackageIndex.value) {
      case 0:
        extraFields.value[index] =
            extraField.copyWith(basicValue: value.toString());
      case 1:
        extraFields.value[index] =
            extraField.copyWith(standardValue: value.toString());
      default:
        extraFields.value[index] =
            extraField.copyWith(premiumValue: value.toString());
    }
    extraFields.notifyListeners();
  }

  void resetExtraFieldValues(ExtraField extraField) {
    int index = 0;
    index =
        extraFields.value.indexWhere((element) => element.id == extraField.id);
    final tempValue = extraFields.value[index];
    if (tempValue.type == FieldType.CHECK) {
      extraFields.value[index] = extraField.copyWith(
        basicValue: "on",
        standardValue: "on",
        premiumValue: "on",
      );
    } else {
      extraFields.value[index] = extraField.copyWith(
        basicValue: "0",
        standardValue: "0",
        premiumValue: "0",
      );
    }
  }

  initProject(ProjectDetails projectDetails) async {
    id = projectDetails.id;
    packages.value[0] = Package(
        name: LocalKeys.basic,
        revision: projectDetails.basicRevision.toString().tryToParse,
        deliveryTime: projectDetails.basicDelivery ?? jobLengths.first,
        regularPrice: projectDetails.basicRegularCharge,
        discountPrice: projectDetails.basicDiscountCharge,
        extraFields: []);
    packages.value[1] = Package(
        name: LocalKeys.standard,
        revision: projectDetails.standardRevision.toString().tryToParse,
        deliveryTime: projectDetails.standardDelivery ?? jobLengths.first,
        regularPrice: projectDetails.standardRegularCharge,
        discountPrice: projectDetails.standardDiscountCharge,
        extraFields: []);
    packages.value[2] = Package(
        name: LocalKeys.premium,
        revision: projectDetails.premiumRevision.toString().tryToParse,
        deliveryTime: projectDetails.premiumDelivery ?? jobLengths.first,
        regularPrice: projectDetails.premiumRegularCharge,
        discountPrice: projectDetails.premiumDiscountCharge,
        extraFields: []);
    projectDetails.projectAttributes?.forEach((element) {
      extraFields.value.add(
        ExtraField(
          id: element.id,
          name: element.checkNumericTitle ?? "",
          type: element.type.toString() == "checkbox"
              ? FieldType.CHECK
              : FieldType.QUANTITY,
          basicValue: element.basicCheckNumeric ?? "on",
          standardValue: element.standardCheckNumeric ?? "on",
          premiumValue: element.premiumCheckNumeric ?? "on",
        ),
      );
    });
    titleController.text = projectDetails.title ?? "";
    slugController.text = projectDetails.slug ?? "";
    descriptionController.text = projectDetails.description ?? "";
    keyEditor.currentState?.setText(projectDetails.description ?? "");
    selectedCategory.value = projectDetails.projectCategory;
    projectDetails.projectSubCategories?.forEach((element) {
      selectedSubcategories.value.add(element);
    });
    oldImage = projectDetails.image;
    multiplePackages.value = projectDetails.offerPackagesAvailableOrNot;
  }
}
