import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xilancer/helper/extension/string_extension.dart';

import '../../data/network/network_api_services.dart';
import '../../helper/app_urls.dart';
import '../../helper/constant_helper.dart';
import '../../helper/local_keys.g.dart';
import '../customizations.dart';

class AccountDeleteService with ChangeNotifier {
  Future tryAccountDelete({password}) async {
    if (AppUrls.deleteAccountUrl.toLowerCase().contains("xilancer.xgenious")) {
      await Future.delayed(const Duration(seconds: 2));
      "This feature is turned off for demo app".showToast();
      return;
    }
    final responseData = await NetworkApiServices().postApi(
        {}, AppUrls.deleteAccountUrl, LocalKeys.deleteAccount,
        headers: acceptJsonAuthHeader);
    if (responseData != null) {
      try {
        if ((sPref?.getString("apple_user_id") ?? "").isNotEmpty) {
          await appleTokenRevoke(sPref!.getString("apple_user_token"),
              sPref!.getString("apple_user_id"));
        }
      } catch (e) {}
      return true;
    }
  }

  appleTokenRevoke(token, id) async {
    if (!Platform.isIOS) {
      return;
    }
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      // "Accept": "application/json",
      'content-type': 'application/x-www-form-urlencoded',
    };

    debugPrint(
        'https://appleid.apple.com/auth/revoke?client_id=$id&client_secret=$clientSecret&token=$token&token_type_hint=access_token');
    var response = await http.post(
      Uri.parse(
          'https://appleid.apple.com/auth/revoke?client_id=$id&client_secret=$clientSecret&token=$token&token_type_hint=access_token'),
      headers: header,
    );
    print(id);
    print(response.statusCode);
    if (response.statusCode == 200) {
      "Apple id revoked successfully".tr().showToast();
    } else {
      "Apple id revoke failed".tr().showToast();
    }
  }
}
