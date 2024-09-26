import 'package:flutter/material.dart';
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../data/network/network_api_services.dart';
import '../models/project_details_model.dart';
import '../views/create_project_view/components/packages_model.dart';

class ProjectDetailsService with ChangeNotifier {
  ProjectDetailsModel? _projectDetailsModel;

  List<PackageForView> _projectPackages = [];
  List<PackageForView> get projectPackages => _projectPackages;
  ProjectDetailsModel get projectDetailsModel =>
      _projectDetailsModel ?? ProjectDetailsModel();
  String token = "";

  bool shouldAutoFetch(id) =>
      (projectDetailsModel.projectDetails?.id).toString() != id ||
      token.isInvalid;

  fetchProjectDetails(id) async {
    token = getToken;
    debugPrint("should details is $shouldAutoFetch".toString());
    var url = "${AppUrls.fetchProjectDetailsUrl}/$id";

    final responseData = await NetworkApiServices().getApi(
        url, LocalKeys.projectDetails,
        headers: acceptJsonAuthHeader, timeoutSeconds: 60);
    if (responseData != null) {
      _projectDetailsModel = ProjectDetailsModel.fromJson(responseData);

      final tempProject = _projectDetailsModel?.projectDetails;
      final List<PackageForView> tempPackages = [];
      final basicPackage = PackageForView(
          name: LocalKeys.basic,
          revision: tempProject?.basicRevision.toString().tryToParse ?? 0,
          deliveryTime: tempProject?.basicDelivery ?? "",
          regularPrice:
              tempProject?.basicRegularCharge.toString().tryToParse ?? 0,
          discountPrice: tempProject?.basicDiscountCharge,
          extraFields: []);
      tempProject?.projectAttributes?.forEach((element) {
        basicPackage.extraFields.add(ExtraFieldForView(
            id: element.id,
            name: element.checkNumericTitle ?? "",
            type: element.type.toString() == "checkbox"
                ? FieldType0.CHECK
                : FieldType0.QUANTITY,
            checked: element.basicCheckNumeric.toString() == "on",
            quantity: element.basicCheckNumeric.toString().tryToParse));
      });
      tempPackages.add(basicPackage);
      if (tempProject?.standardDelivery != null) {
        final standardPackage = PackageForView(
            name: LocalKeys.standard,
            revision: tempProject?.standardRevision.toString().tryToParse ?? 0,
            deliveryTime: (tempProject?.standardDelivery ?? "").toString(),
            regularPrice:
                tempProject?.standardRegularCharge.toString().tryToParse ?? 0,
            discountPrice: tempProject?.standardDiscountCharge,
            extraFields: []);
        tempProject?.projectAttributes?.forEach((element) {
          standardPackage.extraFields.add(ExtraFieldForView(
              id: element.id,
              name: element.checkNumericTitle ?? "",
              type: element.type.toString() == "checkbox"
                  ? FieldType0.CHECK
                  : FieldType0.QUANTITY,
              checked: element.standardCheckNumeric.toString() == "on",
              quantity: element.standardCheckNumeric.toString().tryToParse));
        });
        tempPackages.add(standardPackage);
      }
      if (tempProject?.premiumDelivery != null) {
        final premiumPackage = PackageForView(
            name: LocalKeys.premium,
            revision: tempProject?.premiumRevision.toString().tryToParse ?? 0,
            deliveryTime: tempProject?.premiumDelivery ?? "",
            regularPrice:
                tempProject?.premiumRegularCharge.toString().tryToParse ?? 0,
            discountPrice: tempProject?.premiumDiscountCharge,
            extraFields: []);
        tempProject?.projectAttributes?.forEach((element) {
          premiumPackage.extraFields.add(ExtraFieldForView(
              id: element.id,
              name: element.checkNumericTitle ?? "",
              type: element.type.toString() == "checkbox"
                  ? FieldType0.CHECK
                  : FieldType0.QUANTITY,
              checked: element.premiumCheckNumeric.toString() == "on",
              quantity: element.premiumCheckNumeric.toString().tryToParse));
        });
        tempPackages.add(premiumPackage);
      }
      _projectPackages = tempPackages;
      return true;
    }
  }

  tryStatusChange() async {
    final url = AppUrls.projectStatusChangeUrl;
    final status =
        (projectDetailsModel.projectDetails?.projectOnOff).toString() == "1"
            ? "0"
            : "1";
    final data = {
      'project_id': (projectDetailsModel.projectDetails?.id).toString(),
      'project_on_off': status,
    };

    final responseData = await NetworkApiServices().postApi(
        data, url, LocalKeys.deleteProject,
        headers: acceptJsonAuthHeader);

    if (responseData != null) {
      projectDetailsModel.projectDetails?.projectOnOff = status;
      notifyListeners();
      LocalKeys.statusChangedSuccessfully.showToast();
      return true;
    }
  }

  tryDeleteProject() async {
    final url = AppUrls.projectDeleteUrl;
    final data = {
      "project_id": (projectDetailsModel.projectDetails?.id).toString(),
    };

    final responseData = await NetworkApiServices().postApi(
        data, url, LocalKeys.deleteProject,
        headers: acceptJsonAuthHeader);

    if (responseData != null) {
      LocalKeys.projectDeletedSuccessfully.showToast();
      return true;
    }
  }

  void reset() {
    _projectDetailsModel = null;
  }
}
