import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/models/profile_details_model.dart';
import 'package:xilancer/utils/components/image_pl_widget.dart';
import 'package:xilancer/view_models/profile_details_view_model/profile_details_view_model.dart';

import '../../../helper/svg_assets.dart';

class ProfileDetailsProjectCard extends StatelessWidget {
  final Project project;
  final String projectsPath;
  const ProfileDetailsProjectCard(
      {super.key, required this.project, required this.projectsPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 134,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: "$projectsPath/${project.image}",
                placeholder: (context, url) => const ImagePLWidget(size: 60),
                errorWidget: (context, url, error) =>
                    const ImagePLWidget(size: 60),
              ),
            ),
          ),
          if (project.rating != null) ...[
            16.toHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: context.dProvider.yellowColor.withOpacity(0.10),
                  ),
                  child: FittedBox(
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: context.dProvider.yellowColor,
                          size: 20,
                        ),
                        if (project.rating != null) ...[
                          4.toWidth,
                          Text(
                            "${project.rating}",
                            style: context.titleSmall
                                ?.copyWith(color: context.dProvider.yellowColor)
                                .bold6,
                          )
                        ],
                      ],
                    ),
                  ),
                ),
                if (12 == 1)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: context.dProvider.black8,
                        )),
                    child: Text(
                      "{project.} ${LocalKeys.orderInQueue}",
                      style: context.bodySmall
                          ?.copyWith(color: context.dProvider.black5)
                          .bold6,
                    ),
                  ),
              ],
            )
          ],
          20.toHeight,
          Text(project.title ?? "", style: context.titleMedium?.bold6),
          8.toHeight,
          Row(
            children: [
              Text(
                ((project.basicDiscountCharge ?? project.basicRegularCharge) ??
                        0)
                    .toStringAsFixed(0)
                    .cur,
                style: context.titleMedium
                    ?.copyWith(color: context.dProvider.primaryColor)
                    .bold6,
              ),
              6.toWidth,
              if (project.basicDiscountCharge != null)
                Text(
                  (project.basicRegularCharge ?? 0).toStringAsFixed(0).cur,
                  style: context.titleSmall
                      ?.copyWith(
                          color: context.dProvider.black6,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: context.dProvider.black6)
                      .bold6,
                ),
              const Spacer(),
              SvgAssets.clock.toSVGSized(20),
              8.toWidth,
              Text(LocalKeys.deliveryTime,
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.black5)),
              Text(" ${project.basicDelivery ?? ""}",
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.black5)
                      .bold6)
            ],
          ),
          8.toHeight,
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocalKeys.availableForWork,
                style: context.titleSmall,
              ),
              Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: project.projectOnOff.toString() == "1",
                  onChanged: (value) {
                    ProfileDetailsViewModel.instance
                        .tryProjectStatusChange(context, id: project.id);
                  },
                ),
              ),
            ],
          ),
        ],
      ).hp20,
    );
  }
}
