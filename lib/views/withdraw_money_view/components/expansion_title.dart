import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';

import '../../../helper/local_keys.g.dart';
import '../../../utils/components/empty_spacer_helper.dart';

class ExpansionTitle extends StatelessWidget {
  const ExpansionTitle({
    super.key,
    required this.priceAmount,
    required this.paymentGateway,
    required this.paymentStatus,
    required this.id,
    required this.controller,
    required this.paymentFailed,
  });

  final num priceAmount;
  final String paymentGateway;
  final String paymentStatus;
  final id;
  final ExpansionTileController? controller;
  final bool paymentFailed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "#$id",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.dProvider.primaryColor),
        ),
        4.toHeight,
        Row(
          children: [
            Expanded(
              flex: 28,
              child: Text(
                priceAmount.toStringAsFixed(2).cur,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.dProvider.black3),
              ),
            ),
          ],
        ),
        EmptySpaceHelper.emptyHeight(4),
        Text(
          paymentGateway,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.titleMedium
              ?.copyWith(fontSize: 14, color: context.dProvider.primary80)
              .bold6,
        ),
        Row(
          children: [
            RichText(
              text: TextSpan(
                  text: "${LocalKeys.status}: ",
                  style: context.titleSmall
                      ?.copyWith(fontSize: 14, color: context.dProvider.black3),
                  children: [
                    TextSpan(
                      text: paymentStatus,
                      style: context.titleSmall?.copyWith(
                          color: paymentStatus.toString() == LocalKeys.canceled
                              ? context.dProvider.warningColor
                              : (paymentStatus.toString() == LocalKeys.complete
                                  ? context.dProvider.greenColor
                                  : context.dProvider.yellowColor)),
                    )
                  ]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        EmptySpaceHelper.emptyHeight(4),
      ],
    );
  }
}
