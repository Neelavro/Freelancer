import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/bookmark_data_service.dart';
import 'package:xilancer/views/fixed_price_job_details_view/fixed_price_job_details_view.dart';

import '../../../helper/svg_assets.dart';

class JobCard extends StatelessWidget {
  final id;
  final title;
  final isFavorite;
  final createDate;
  final expertise;
  final price;
  final priceType;
  final summery;
  final List<String> tags;
  final location;
  final proposalCount;
  final deadline;

  final rating;
  final bool fromDetails;
  final bool userVerified;
  const JobCard(
      {super.key,
      this.id,
      required this.title,
      required this.isFavorite,
      required this.createDate,
      required this.expertise,
      required this.price,
      required this.priceType,
      required this.summery,
      required this.tags,
      required this.location,
      required this.proposalCount,
      required this.deadline,
      required this.rating,
      this.fromDetails = false,
      required this.userVerified});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fromDetails
          ? null
          : () {
              debugPrint(priceType.toString());
              if (priceType == "Fixed") {
                context.toNamed(FixedPriceJobDetailsView.routeName,
                    arguments: [id, title]);
              }
            },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: context.dProvider.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                color: context.dProvider.whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 30,
                          child: Text(
                            title,
                            style: context.titleMedium?.bold6,
                          )),
                      const Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Consumer<BookmarkDataService>(
                                builder: (context, bd, child) {
                              final isBookmarked =
                                  bd.isBookmarked(id.toString());
                              return GestureDetector(
                                onTap: () {
                                  final data = {
                                    'id': id,
                                    'title': title,
                                    'isFavorite': isFavorite,
                                    'createDate': createDate?.toIso8601String(),
                                    'expertise': expertise,
                                    'price': price,
                                    'priceType': priceType,
                                    'summery': summery,
                                    'tags': tags,
                                    'location': location,
                                    'proposalCount': proposalCount,
                                    'deadline': deadline,
                                    'rating': rating,
                                    'fromDetails': fromDetails,
                                    'userVerified': userVerified,
                                  };

                                  bd.toggleBookmark(id.toString(), data);
                                },
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: isBookmarked
                                        ? context.dProvider.primaryColor
                                        : context.dProvider.black8,
                                  ),
                                  child: (isBookmarked
                                          ? SvgAssets.bookmarkSub
                                          : SvgAssets.bookmarkAdd)
                                      .toSVGSized(18,
                                          color: isBookmarked
                                              ? context.dProvider.whiteColor
                                              : null),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  6.toHeight,
                  RichText(
                      text: TextSpan(
                          text:
                              "${DateFormat("MMM dd,yyyy").format(createDate ?? DateTime.now())} . ",
                          style: context.titleSmall,
                          children: [
                        TextSpan(
                            text: expertise,
                            style: context.titleSmall
                                ?.copyWith(
                                    color: context.dProvider.primaryColor)
                                .bold6)
                      ])),
                  6.toHeight,
                  Row(
                    children: [
                      Text(
                        price.toString().cur,
                        style: context.titleMedium
                            ?.copyWith(color: context.dProvider.primaryColor)
                            .bold6,
                      ),
                      6.toWidth,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: context.dProvider.yellowColor,
                            )),
                        child: Text(
                          priceType,
                          style: context.titleSmall
                              ?.copyWith(color: context.dProvider.yellowColor)
                              .bold6,
                        ),
                      )
                    ],
                  ),
                  if (fromDetails) 6.toHeight,
                  if (fromDetails)
                    HtmlWidget(
                      summery,
                      textStyle: context.titleSmall
                          ?.copyWith(color: context.dProvider.black5),
                    ),
                  12.toHeight,
                  Wrap(
                    runSpacing: 12,
                    spacing: 12,
                    children: tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.dProvider.black9,
                        ),
                        child: Text(
                          tag,
                          style: context.bodySmall,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6)),
                color: context.dProvider.primary05,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      runSpacing: 12,
                      spacing: 12,
                      children: [
                        Infos(
                            svgIcon: SvgAssets.location.toSVGSized(18,
                                color: context.dProvider.black6),
                            text: location),
                        Infos(
                            svgIcon: SvgAssets.task.toSVGSized(18,
                                color: context.dProvider.black6),
                            text: "${LocalKeys.proposals}: $proposalCount"),
                        Infos(
                            svgIcon: SvgAssets.card.toSVGSized(18,
                                color: context.dProvider.black6),
                            text: userVerified
                                ? LocalKeys.verified
                                : LocalKeys.notVerified),
                        Infos(
                            svgIcon: SvgAssets.clock.toSVGSized(18,
                                color: context.dProvider.black6),
                            text: deadline.toString().capitalize.tr()),
                      ],
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

String formatDateTime(DateTime date) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(date);

  if (difference.inSeconds < 60) {
    return 'moments ago';
  } else if (difference.inMinutes < 60) {
    int minutes = difference.inMinutes;
    return '$minutes minute${minutes > 1 ? 's' : ''} ago';
  } else if (difference.inHours < 24) {
    int hours = difference.inHours;
    return '$hours hour${hours > 1 ? 's' : ''} ago';
  } else if (difference.inDays < 30) {
    int days = difference.inDays;
    return '$days day${days > 1 ? 's' : ''} ago';
  } else if (difference.inDays < 365) {
    int months = (now.year - date.year) * 12 + (now.month - date.month);
    return '$months month${months > 1 ? 's' : ''} ago';
  } else {
    int years = now.year - date.year;
    return '$years year${years > 1 ? 's' : ''} ago';
  }
}

class Infos extends StatelessWidget {
  const Infos({
    super.key,
    required this.svgIcon,
    required this.text,
  });

  final text;
  final svgIcon;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [svgIcon, 6.toWidth, Text(text)],
      ),
    );
  }
}
