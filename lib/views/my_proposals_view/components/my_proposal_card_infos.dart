import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/image_assets.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/views/my_order_details_view/components/earning_tiles.dart';
import 'package:xilancer/views/my_orders_view/components/my_order_id.dart';
import 'package:xilancer/app_static_values.dart' as apps;

import '../../../helper/svg_assets.dart';
import '../../chat_list_view/components/chat_tile_avatar.dart';

class MyProposalCardInfos extends StatelessWidget {
  const MyProposalCardInfos({
    super.key,
    required this.id,
    required this.budget,
    this.deadline,
    this.isSeen,
    this.isRejected,
    this.isInterviewed,
    this.isShortListed,
    this.fromDetails = false,
    this.createdAt,
    this.jobTitle,
    this.attachment,
    this.description,
  });

  final id;
  final deadline;
  final budget;
  final fromDetails;
  final createdAt;
  final jobTitle;
  final isSeen;
  final isRejected;
  final isInterviewed;
  final isShortListed;
  final attachment;
  final description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyOrderId(
          id: "#$id",
        ).hp20,
        8.toHeight,
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            if (isSeen is bool)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isSeen != true
                      ? context.dProvider.warningColor.withOpacity(.05)
                      : context.dProvider.greenColor.withOpacity(.05),
                ),
                child: Text(
                  isSeen ? LocalKeys.seen : LocalKeys.notSeen,
                  style: context.titleSmall?.copyWith(
                      color: isSeen != true
                          ? context.dProvider.warningColor
                          : context.dProvider.greenColor),
                ),
              ),
            if (isShortListed == true)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.dProvider.primaryColor.withOpacity(.05),
                ),
                child: Text(
                  LocalKeys.shortListed,
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.primaryColor),
                ),
              ),
            if (isInterviewed == true)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.dProvider.greenColor.withOpacity(.05),
                ),
                child: Text(
                  LocalKeys.interviewed,
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.greenColor),
                ),
              ),
            if (isRejected == true)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.dProvider.greenColor.withOpacity(.05),
                ),
                child: Text(
                  LocalKeys.rejected,
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.greenColor),
                ),
              ),
          ],
        ).hp20,
        if (createdAt != null) ...[
          8.toHeight,
          Text(
            timeAgo.format(createdAt,
                locale: context.dProvider.languageSlug.substring(0, 2)),
            style:
                context.titleSmall?.copyWith(color: context.dProvider.black5),
          ).hp20,
        ],
        Divider(
          color: context.dProvider.black8,
          thickness: 2,
          height: 24,
        ),
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  LocalKeys.offerPrice,
                  style: context.titleSmall?.black5,
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Text(
                      "$budget".cur,
                      style: context.titleSmall?.bold6,
                    ),
                  ],
                ),
              ),
            ],
          ).hp20,
        ),
        Divider(
          color: context.dProvider.black8,
          thickness: 2,
          height: 24,
        ),
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  LocalKeys.deliveryTime,
                  style: context.titleSmall?.black5,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  deadline is String ? deadline : LocalKeys.byMilestone,
                  style: context.titleSmall?.bold6,
                ),
              ),
            ],
          ).hp20,
        ),
        if (jobTitle != null) ...[
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
            height: 24,
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    LocalKeys.jobTitle,
                    style: context.titleSmall?.black5,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    jobTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleSmall?.bold6,
                  ),
                ),
              ],
            ).hp20,
          ),
        ],
        if (description != null) ...[
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
            height: 24,
          ),
          Text(
            description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style:
                context.titleSmall?.copyWith(color: context.dProvider.black5),
          ).hp20
        ],
      ],
    );
  }
}
