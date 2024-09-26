import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/utils/components/text_skeleton.dart';

class JobCardSkeleton extends StatelessWidget {
  final bool fromDetails;
  const JobCardSkeleton({
    super.key,
    required this.fromDetails,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextSkeleton(
                        height: 16,
                        width: context.width / 1.5,
                      ),
                      Container(
                        height: 32,
                        width: 32,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.dProvider.black8,
                        ),
                      ),
                    ],
                  ),
                  6.toHeight,
                  TextSkeleton(
                    height: 14,
                    width: context.width / 2.5,
                  ),
                  6.toHeight,
                  Row(
                    children: [
                      const TextSkeleton(
                        height: 16,
                        width: 60,
                      ),
                      6.toWidth,
                      Container(
                        height: 18,
                        width: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: context.dProvider.black8,
                        ),
                      )
                    ],
                  ),
                  if (fromDetails) 6.toHeight,
                  if (fromDetails)
                    TextSkeleton(height: 14, width: context.width / 1.5),
                  if (fromDetails) 4.toHeight,
                  if (fromDetails)
                    TextSkeleton(height: 14, width: context.width / 2),
                  if (fromDetails) 4.toHeight,
                  if (fromDetails)
                    TextSkeleton(height: 14, width: context.width / 1.7),
                  12.toHeight,
                  Wrap(
                    runSpacing: 12,
                    spacing: 12,
                    children: [1, 2].map((e) {
                      return Container(
                        height: 14,
                        width: e * 40,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.dProvider.black9,
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
              child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      runSpacing: 12,
                      spacing: 12,
                      children: [
                        TextSkeleton(height: 16, width: 80),
                        TextSkeleton(height: 16, width: 150),
                        TextSkeleton(height: 16, width: 40),
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
