import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../../../helper/constant_helper.dart';
import '../../../helper/image_assets.dart';
import '../../chat_list_view/components/chat_tile_avatar.dart';
import '../../notifications_list_view/components/notification_list_tile.dart';

class JobDetailsProposalCard extends StatelessWidget {
  final title;
  final occupation;
  final location;
  final rating;
  final jobCompleteCount;
  final submitDate;
  final String offeredPrice;
  final estDuration;
  final image;
  const JobDetailsProposalCard(
      {super.key,
      this.title,
      this.occupation,
      this.location,
      this.rating,
      this.jobCompleteCount,
      this.submitDate,
      required this.offeredPrice,
      this.image,
      this.estDuration});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        4.toHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ChatTileAvatar(
              placeHolderImage: ImageAssets.avatar,
              name: "",
              size: 44.0,
              imageUrl: image.toString(),
            )),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.titleMedium?.bold6,
                    ),
                    8.toHeight,
                    Text(
                      "$occupation . $location",
                      style: context.titleSmall?.bold6
                          .copyWith(color: context.dProvider.black5),
                    ),
                    8.toHeight,
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color:
                                context.dProvider.yellowColor.withOpacity(0.05),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.star_rounded,
                                  size: 16,
                                  color: context.dProvider.yellowColor),
                              Text(
                                "$rating",
                                style: context.titleSmall?.copyWith(
                                    color: context.dProvider.yellowColor),
                              ),
                            ],
                          ),
                        ),
                        8.toWidth,
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: context.dProvider.black8,
                              )),
                          child: Row(
                            children: [
                              Text(
                                "$jobCompleteCount ${LocalKeys.jobsComplete}",
                                style: context.titleSmall
                                    ?.copyWith(color: context.dProvider.black5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    8.toHeight,
                    Text(
                      formatDateTime(submitDate),
                      style: context.titleSmall
                          ?.copyWith(color: context.dProvider.black5),
                    ),
                  ],
                ))
          ],
        ),
        Divider(
          color: context.dProvider.black8,
          thickness: 2,
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              flex: 6,
              child: RichText(
                  text: TextSpan(
                      text: "${LocalKeys.offered}: ",
                      style: context.titleMedium
                          ?.copyWith(color: context.dProvider.black5),
                      children: [
                    TextSpan(
                        text: offeredPrice.cur,
                        style: context.titleSmall?.bold6
                            .copyWith(color: context.dProvider.primaryColor)),
                  ])),
            ),
            Expanded(
                flex: 1,
                child: SizedBox(
                  height: 24,
                  child: VerticalDivider(
                      thickness: 2, color: context.dProvider.black8),
                )),
            Expanded(
              flex: 6,
              child: RichText(
                  text: TextSpan(
                      text: "${LocalKeys.estDeliveryDuration}: ",
                      style: context.titleMedium
                          ?.copyWith(color: context.dProvider.black5),
                      children: [
                    TextSpan(
                        text: estDuration,
                        style: context.titleSmall?.bold6
                            .copyWith(color: context.dProvider.primaryColor)),
                  ])),
            ),
          ],
        )
      ],
    ).hp20;
  }
}
