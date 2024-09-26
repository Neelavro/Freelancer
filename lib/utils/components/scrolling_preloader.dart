import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

class ScrollPreloader extends StatelessWidget {
  final bool whiteColor;
  final double? width;
  final bool loading;
  final String? text;
  final IconData? iconData;
  const ScrollPreloader({
    super.key,
    this.whiteColor = false,
    this.width,
    required this.loading,
    this.text,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    switch (loading) {
      case false:
        return Column(
          children: [
            Icon(
              iconData ?? Icons.arrow_circle_up_rounded,
              color: context.dProvider.black6,
            ),
            Text(
              text ?? LocalKeys.pullUp,
              style: context.titleSmall?.copyWith(
                color: context.dProvider.black6,
              ),
            ),
          ],
        );
      default:
        return Container(
            width: width,
            height: whiteColor ? null : 36,
            alignment: Alignment.center,
            child: LottieBuilder.asset(
                'assets/animations/${whiteColor ? 'xilancer_preloader_white' : 'xilancer_preloader'}.json'));
    }
  }
}
