import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/services/send_offer_service.dart';

import '../../app_static_values.dart';
import '../../helper/local_keys.g.dart';
import 'milestone_model.dart';

class SendOfferViewModel {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> milestone = ValueNotifier(false);
  ValueNotifier<List<Milestone>> milestones = ValueNotifier([]);

  ValueNotifier<String?> selectedDDate = ValueNotifier(jobLengths.firstOrNull);
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController revisionController = TextEditingController();

  ValueNotifier<String?> mSelectedDDate = ValueNotifier(jobLengths.firstOrNull);
  TextEditingController milestoneDescriptionController =
      TextEditingController();
  TextEditingController mNameController = TextEditingController();
  TextEditingController mPriceController = TextEditingController();
  TextEditingController mRevisionController = TextEditingController();

  final GlobalKey<FlutterSummernoteState> keyEditor =
      GlobalKey(debugLabel: DateTime.now().millisecondsSinceEpoch.toString());
  final GlobalKey<FlutterSummernoteState> mKeyEditor =
      GlobalKey(debugLabel: DateTime.now().millisecondsSinceEpoch.toString());

  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormState> mFormKey = GlobalKey();

  SendOfferViewModel._init();
  static SendOfferViewModel? _instance;
  static SendOfferViewModel get instance {
    _instance ??= SendOfferViewModel._init();
    return _instance!;
  }

  SendOfferViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  resetMilestoneSheet({
    name,
    price,
    desc,
    revision,
    dTime,
  }) {
    mSelectedDDate.value = dTime ?? jobLengths.firstOrNull;
    mNameController.text = name ?? "";
    mPriceController.text = price?.toString() ?? "";
    milestoneDescriptionController.text = desc ?? "";
    mRevisionController.text = revision?.toString() ?? "";
  }

  void addMilestone(BuildContext context) async {
    final valid = mFormKey.currentState?.validate();
    if (valid != true) {
      return;
    }
    if (mSelectedDDate.value == null) {
      LocalKeys.selectDeliveryTime.showToast();
      return;
    }
    String? etEditor = await mKeyEditor.currentState?.getText();
    etEditor = await mKeyEditor.currentState?.getText();
    debugPrint((etEditor).toString());
    if (etEditor == null) {
      LocalKeys.enterSomeDescription.showToast();
      return;
    }
    milestoneDescriptionController.text = etEditor;
    if (milestoneDescriptionController.text.length < 5) {
      LocalKeys.enterSomeDescription.showToast();
      return;
    }
    final id = milestones.value.length;
    milestones.value.add(
      Milestone(
        id: id,
        name: mNameController.text,
        description: milestoneDescriptionController.text,
        price: mPriceController.text.tryToParse,
        revision: mRevisionController.text.tryToParse,
        dTime: mSelectedDDate.value!,
      ),
    );
    milestones.notifyListeners();
    context.popFalse;
  }

  void editMilestone(BuildContext context, id) async {
    final valid = mFormKey.currentState?.validate();
    if (valid != true) {
      return;
    }
    if (mSelectedDDate.value == null) {
      LocalKeys.selectDeliveryTime.showToast();
      return;
    }
    String? etEditor = await mKeyEditor.currentState?.getText();
    etEditor = await mKeyEditor.currentState?.getText();
    debugPrint((etEditor).toString());
    if (etEditor == null) {
      LocalKeys.enterSomeDescription.showToast();
      return;
    }
    milestoneDescriptionController.text = etEditor;
    if (milestoneDescriptionController.text.length < 5) {
      LocalKeys.enterSomeDescription.showToast();
      return;
    }
    milestones.value[id] = Milestone(
      id: milestones.value.length,
      name: mNameController.text,
      description: milestoneDescriptionController.text,
      price: mPriceController.text.tryToParse,
      revision: mRevisionController.text.tryToParse,
      dTime: mSelectedDDate.value!,
    );
    milestones.notifyListeners();
    context.popFalse;
  }

  void removeMilestone(id) {
    milestones.value
        .removeWhere((element) => element.id.toString() == id.toString());
    milestones.notifyListeners();
  }

  trySendingOffer(BuildContext context, {clientId}) async {
    final valid = formKey.currentState?.validate();
    if (valid != true) {
      return;
    }
    if (milestone.value && milestones.value.length < 2) {
      LocalKeys.addMilestone.showToast();
      return;
    }
    String? etEditor = await keyEditor.currentState?.getText();
    etEditor = await keyEditor.currentState?.getText();
    debugPrint((etEditor).toString());
    if (!milestone.value && etEditor == null) {
      LocalKeys.enterSomeDescription.showToast();
      return;
    }
    descriptionController.text = etEditor ?? "";
    if (!milestone.value && descriptionController.text.length < 5) {
      LocalKeys.enterSomeDescription.showToast();
      return;
    }
    isLoading.value = true;
    await Provider.of<SendOfferService>(context, listen: false)
        .trySendingOffer(clientId: clientId)
        .then((v) {
      if (v == true) {
        LocalKeys.offerSentSuccessfully.showToast();
        context.popFalse;
      }
    });

    isLoading.value = false;
  }
}
