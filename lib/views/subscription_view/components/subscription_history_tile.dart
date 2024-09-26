import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';

import '../../../helper/local_keys.g.dart';

class SubscriptionHistoryTile extends StatelessWidget {
  final String limit;
  final String type;
  final String price;
  final String sStatus;
  final String pStatus;
  final DateTime? pDate;
  final DateTime eDate;
  const SubscriptionHistoryTile(
      {super.key,
      required this.limit,
      required this.type,
      required this.price,
      required this.sStatus,
      required this.pStatus,
      this.pDate,
      required this.eDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: context.dProvider.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                      text: limit,
                      style: context.titleLarge?.bold6,
                      children: [
                    TextSpan(
                        text: "/$type",
                        style: context.titleSmall
                            ?.copyWith(color: context.dProvider.black5)),
                  ])),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: statusColor.withOpacity(.05),
                ),
                child: Text(
                  subsStatus,
                  style: context.titleSmall?.copyWith(color: statusColor),
                ),
              ),
            ],
          ),
          8.toHeight,
          RichText(
              text: TextSpan(
                  text: "${LocalKeys.paymentStatus}: ",
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.black5),
                  children: [
                TextSpan(
                    text: LocalKeys.complete,
                    style: context.titleSmall
                        ?.copyWith(color: context.dProvider.greenColor)),
              ])),
          8.toHeight,
          RichText(
              text: TextSpan(
                  text: "${LocalKeys.expireDate}: ",
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.black5),
                  children: [
                TextSpan(
                    text: DateFormat("MMM dd, yyyy", dProvider.languageSlug)
                        .format(eDate),
                    style: context.titleSmall?.copyWith(color: eDateColor)),
              ]))
        ],
      ),
    );
  }

  Color get eDateColor {
    final now = DateTime.now();
    if (eDate.isBefore(now)) {
      return dProvider.black3;
    }
    if (eDate.difference(now).inDays < 7) {
      return dProvider.yellowColor;
    }
    return dProvider.primaryColor;
  }

  String get subsStatus {
    if (sStatus == "0") {
      return LocalKeys.inactive;
    }
    if (DateTime.now().isAfter(eDate)) {
      return LocalKeys.expired;
    }
    return LocalKeys.active;
  }

  Color get statusColor {
    if (sStatus == "0") {
      return dProvider.yellowColor;
    }
    if (DateTime.now().isAfter(eDate)) {
      return dProvider.warningColor;
    }
    return dProvider.greenColor;
  }
}
