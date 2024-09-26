import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/view_models/sign_in_view/social_sign_in_view_model.dart';
import 'package:xilancer/views/sign_in_view/sign_in_view.dart';

import '../../view_models/sign_in_view/sign_in_view_model.dart';
import '../../view_models/sign_up_view/sign_up_view_model.dart';

class AccountSkeleton extends StatelessWidget {
  const AccountSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      color: context.dProvider.whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "assets/animations/sign_in.json",
            // width: context.width / 1.7,
            // height: context.width / 1.7,
            fit: BoxFit.cover,
            repeat: false,
          ),
          SizedBox(
            width: context.width / 2,
            child: CustomButton(
              onPressed: () {
                SignInViewModel.dispose;
                SignInViewModel.instance.initSavedInfo();
                SignUpViewModel.dispose;
                SocialSignInViewModel.dispose;
                context.toNamed(SignInView.routeName);
              },
              btText: LocalKeys.signIn,
              isLoading: false,
            ),
          )
        ],
      ),
    );
  }
}
