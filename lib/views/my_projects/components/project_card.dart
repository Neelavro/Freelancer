import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/project_details_service.dart';

import '../../../helper/svg_assets.dart';
import '../../../models/my_projects_model.dart';
import '../../../utils/components/image_pl_widget.dart';
import '../../../view_models/project_details_view_model/project_details_view_model.dart';
import '../../project_details_view/project_details_view.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final String projectsPath;
  final bool pop;
  const ProjectCard(
      {super.key,
      required this.project,
      required this.projectsPath,
      this.pop = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ProjectDetailsViewModel.dispose;
        Provider.of<ProjectDetailsService>(context, listen: false).reset();
        context.toNamed(
          ProjectDetailsView.routeName,
          arguments: [project.id],
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: (context.width - 72) * 0.54237,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: "$projectsPath/${project.image}",
                      placeholder: (context, url) =>
                          const ImagePLWidget(size: 60),
                      errorWidget: (context, url, error) =>
                          const ImagePLWidget(size: 60),
                    ),
                  ),
                ),
                if (project.status.toString() == "0")
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: context.dProvider.yellowColor,
                    ),
                    child: Text(
                      LocalKeys.pending,
                      style: context.titleSmall
                          ?.copyWith(color: context.dProvider.whiteColor)
                          .bold6,
                    ),
                  )
              ],
            ),
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
                        if (project.ratingsCount > 0)
                          Icon(
                            Icons.star_rounded,
                            color: context.dProvider.yellowColor,
                            size: 20,
                          ),
                        Text(
                          project.ratingsCount > 0
                              ? "${project.ratingsAvgRating.toStringAsFixed(1)}(${project.ratingsCount})"
                              : LocalKeys.noReview,
                          style: context.titleSmall
                              ?.copyWith(color: context.dProvider.yellowColor)
                              .bold6,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: context.dProvider.greenColor.withOpacity(.20),
                  ),
                  child: Text(
                    project.completeOrdersCount > 0
                        ? "${project.completeOrdersCount} ${LocalKeys.ordersCompleted}"
                        : LocalKeys.noOrder,
                    style: context.bodySmall
                        ?.copyWith(color: context.dProvider.greenColor)
                        .bold6,
                  ),
                ),
              ],
            ),
            8.toHeight,
            Text(project.title ?? "", style: context.titleMedium?.bold6),
            8.toHeight,
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "${LocalKeys.from}: ",
                              style: context.titleMedium
                                  ?.copyWith(color: context.dProvider.black6)
                                  .bold6,
                              children: [
                            TextSpan(
                              text:
                                  "${((project.basicDiscountCharge ?? project.basicRegularCharge)).toStringAsFixed(0).cur} ",
                              style: context.titleMedium
                                  ?.copyWith(
                                      color: context.dProvider.primaryColor)
                                  .bold6,
                            ),
                            if ((project.basicDiscountCharge ?? 0) > 0)
                              TextSpan(
                                text:
                                    " ${(project.basicRegularCharge).toStringAsFixed(0).cur}",
                                style: context.titleSmall
                                    ?.copyWith(
                                        color: context.dProvider.black6,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor:
                                            context.dProvider.black6)
                                    .bold6,
                              ),
                          ]))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgAssets.clock.toSVGSized(20),
                      8.toWidth,
                      Expanded(
                        flex: 1,
                        child: RichText(
                          maxLines: 3,
                          text: TextSpan(
                              text: LocalKeys.deliveryTime,
                              style: context.titleSmall
                                  ?.copyWith(color: context.dProvider.black5),
                              children: [
                                TextSpan(
                                    text: " ${project.basicDelivery ?? ""}",
                                    style: context.titleSmall
                                        ?.copyWith(
                                            color: context.dProvider.black5)
                                        .bold6)
                              ]),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
