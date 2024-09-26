import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/auth/sign_in_service.dart';
import 'package:xilancer/services/profile_info_service.dart';

import '../../services/chat_credential_service.dart';
import '../../services/push_notification_service.dart';

class SocialSignInViewModel {
  final googleSignIn = GoogleSignIn();
  String type = "";
  String fName = "";
  String lName = "";
  String id = "";
  String email = "";

  SocialSignInViewModel._init();
  static SocialSignInViewModel? _instance;
  static SocialSignInViewModel get instance {
    _instance ??= SocialSignInViewModel._init();
    return _instance!;
  }

  SocialSignInViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  trySocialSignIn(
    BuildContext context, {
    type = "google",
  }) async {
    try {
      switch (type) {
        case "facebook":
          await facebook();
          break;
        case "apple":
          await apple();
          break;
        default:
          await google();
      }

      final result = await Provider.of<SignInService>(context, listen: false)
          .trySocialSignIn(
        type: type,
        fName: fName,
        lName: lName,
        email: email,
        id: id,
      );
      if (result == true) {
        Provider.of<ChatCredentialService>(context, listen: false)
            .fetchCredentials();
        await PushNotificationService().updateDeviceToken(forceUpdate: true);
        await Provider.of<ProfileInfoService>(context, listen: false)
            .fetchProfileInfo();
        context.popFalse;
      }
    } catch (e) {
      LocalKeys.signInFailed.showToast();
    }
  }

  google() async {
    final googleUser = await googleSignIn.signIn();

    print(googleUser?.displayName);
    if (googleUser == null) {
      LocalKeys.signInFailed.showToast();
      return;
    }
    GoogleSignInAccount? user = googleUser;

    type = "google";
    fName = user.displayName?.split(" ").firstOrNull ?? "";
    try {
      lName = user.displayName?.split(" ").sublist(1).join(" ") ?? "";
    } catch (e) {
      lName = user.displayName ?? "";
    }
    email = user.email;
    id = user.id;
  }

  facebook() async {
    final facebookAuth = FacebookAuth.instance;
    final token = await facebookAuth.accessToken;
    var userDetails = {};
    //that means user is logged in

    if (token == null) {
      final LoginResult result = await facebookAuth.login();
      if (result.status != LoginStatus.success) {
        throw "";
      }
    }
    // final data = await facebookAuth.getUserData();

    userDetails = await facebookAuth.getUserData(
      fields: "name,email",
    );

    type = "facebook";
    fName = userDetails["name"].split(" ").firstOrNull ?? "";
    try {
      lName = userDetails["name"].split(" ").sublist(1).join(" ") ?? "";
    } catch (e) {
      lName = userDetails["name"];
    }
    email = userDetails["email"];
    id = userDetails["id"];
  }

  apple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      fName = credential.givenName ?? "";
      lName = credential.familyName ?? "";
      email = credential.email ?? "";
      id = credential.userIdentifier ?? "";
      type = "apple";

      sPref?.setString("apple_user_token", credential.identityToken ?? "");
      sPref?.setString("apple_user_id", credential.userIdentifier ?? "");
    } catch (e) {}
  }
}
