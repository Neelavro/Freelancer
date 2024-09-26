import 'dart:io';

import 'package:flutter/material.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/empty_spacer_helper.dart';
import 'package:xilancer/view_models/sign_in_view/social_sign_in_view_model.dart';

import 'social_sign_in_button.dart';

class SocialSignIn extends StatelessWidget {
  const SocialSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ssi = SocialSignInViewModel.instance;
    return Column(
      children: [
        SocialSignInButton(
          title: LocalKeys.signInWithGoogle,
          image: "google",
          onTap: () async {
            await ssi.trySocialSignIn(context);
          },
        ),
        EmptySpaceHelper.emptyHeight(16),
        SocialSignInButton(
          title: LocalKeys.signInWithFacebook,
          image: "facebook",
          onTap: () async {
            await ssi.trySocialSignIn(context, type: "facebook");
          },
        ),
        if (Platform.isIOS) ...[
          EmptySpaceHelper.emptyHeight(16),
          SocialSignInButton(
            title: LocalKeys.signInWithApple,
            image: "apple",
            onTap: () async {
              await ssi.trySocialSignIn(context, type: "apple");
            },
          ),
        ],
      ],
    );
  }
}
