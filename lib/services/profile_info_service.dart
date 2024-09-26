import 'package:flutter/material.dart';

import '../../data/network/network_api_services.dart';
import '../../helper/app_urls.dart';
import '../../helper/constant_helper.dart';
import '../../models/profile_info_model.dart';

class ProfileInfoService with ChangeNotifier {
  ProfileInfoModel? _profileInfoModel;

  ProfileInfoModel get profileInfoModel =>
      _profileInfoModel ?? ProfileInfoModel();

  Future fetchProfileInfo() async {
    debugPrint(getToken.toString());
    debugPrint(commonAuthHeader.toString());
    final responseData = await NetworkApiServices().getApi(
        AppUrls.profileInfoUrl, null,
        headers: acceptJsonAuthHeader, timeoutSeconds: 60);
    if (responseData != null) {
      _profileInfoModel = ProfileInfoModel.fromJson(responseData);
      notifyListeners();
      return true;
    } else {}
    notifyListeners();
  }

  void reset() {
    _profileInfoModel = null;
    notifyListeners();
  }
}
