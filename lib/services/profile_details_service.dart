import 'package:flutter/material.dart';
import 'package:xilancer/data/network/network_api_services.dart';
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';

import '../helper/local_keys.g.dart';
import '../models/profile_details_model.dart';

class ProfileDetailsService with ChangeNotifier {
  ProfileDetailsModel? _profileDetails;
  ProfileDetailsModel get profileDetails =>
      _profileDetails ?? ProfileDetailsModel();
  var token = "";

  bool get shouldAutoFetch => _profileDetails == null || token.isInvalid;

  fetchProfileDetails() async {
    token = getToken;
    final responseData = await NetworkApiServices().getApi(
        AppUrls.profileDetailsUrl, LocalKeys.profileDetails,
        headers: commonAuthHeader);
    if (responseData != null) {
      _profileDetails = ProfileDetailsModel.fromJson(responseData);
    }
    notifyListeners();
  }

  tryChangingStatus() async {
    final url = AppUrls.profileStatusChangeUrl;
    final status =
        (profileDetails.user?.checkWorkAvailability).toString() == "1"
            ? "0"
            : "1";
    final data = {
      'check_work_availability': status,
    };

    final responseData = await NetworkApiServices().postApi(
        data, url, LocalKeys.deleteProject,
        headers: acceptJsonAuthHeader);

    if (responseData != null) {
      profileDetails.user?.checkWorkAvailability = status;
      notifyListeners();
      LocalKeys.statusChangedSuccessfully.showToast();
      return true;
    }
  }

  tryStatusChange({required id}) async {
    final url = AppUrls.projectStatusChangeUrl;
    if (AppUrls.projectStatusChangeUrl
        .toLowerCase()
        .contains("xilancer.xgenious")) {
      await Future.delayed(const Duration(seconds: 2));
      "This feature is turned off for demo app".showToast();
      return;
    }
    try {
      debugPrint(id.toString());
      final status = (profileDetails.projects
                      ?.firstWhere(
                          (element) => element.id.toString() == id.toString())
                      .projectOnOff)
                  .toString() ==
              "1"
          ? "0"
          : "1";
      final data = {
        'project_id': id?.toString(),
        'project_on_off': status,
      };

      final responseData = await NetworkApiServices().postApi(
          data, url, LocalKeys.deleteProject,
          headers: acceptJsonAuthHeader);

      if (responseData != null) {
        profileDetails.projects
            ?.firstWhere((element) => element.id.toString() == id.toString())
            .projectOnOff = status;
        notifyListeners();
        LocalKeys.statusChangedSuccessfully.showToast();
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
