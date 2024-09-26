import 'package:flutter/material.dart';

import '../../customizations.dart';
import '../../data/network/network_api_services.dart';
import '../../helper/app_urls.dart';
import '../../helper/constant_helper.dart';
import '../../helper/extension/string_extension.dart';
import '../../helper/local_keys.g.dart';

class SignInService with ChangeNotifier {
  bool emailVerified = true;
  var emailToken = "";
  var token = "";
  var email = "";
  var userId = "";
  Future trySignIn(
      {required String emailUsername, required String password}) async {
    final data = {'email_or_username': emailUsername, 'password': password};
    final responseData = await NetworkApiServices().postApi(
      data,
      AppUrls.signInUrl,
      LocalKeys.signIn,
    );

    if (responseData != null && responseData.containsKey("token")) {
      LocalKeys.signedInSuccessfully.showToast();
      token = responseData["token"] ?? "";
      emailVerified =
          responseData["user"]["is_email_verified"].toString() == "1";
      emailToken = responseData["user"]["email_verify_token"]?.toString() ?? "";
      email = responseData["user"]["email"] ?? "";
      userId = responseData["user"]["id"]?.toString() ?? "";
      debugPrint(getToken.toString());
      return emailVerified;
    } else if (responseData != null && responseData.containsKey("message")) {
      responseData["message"]?.toString().showToast();
    }
  }

  trySocialSignIn({
    required String type,
    required String fName,
    required String lName,
    required String email,
    required String id,
  }) async {
    final url = AppUrls.socialSignInUrl;

    final data = {
      'email': email,
      'source': type,
      'firstname': fName,
      'lastname': lName,
      'is_go_fb_ap_id': id
    };

    final headers = {
      'Accept': 'application/json',
      'secretKey': socialSignInKey
    };

    final responseData = await NetworkApiServices()
        .postApi(data, url, LocalKeys.signInWithGoogle, headers: headers);

    if (responseData != null) {
      setToken(responseData["token"]);
      return true;
    }
  }
}
