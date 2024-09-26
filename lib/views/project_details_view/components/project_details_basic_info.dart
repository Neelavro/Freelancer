import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/project_details_service.dart';
import 'package:xilancer/utils/components/image_pl_widget.dart';
import 'package:xilancer/view_models/project_details_view_model/project_details_view_model.dart';
import 'package:xilancer/views/project_details_view/components/project_details_buttons.dart';

class ProjectDetailsBasicInfo extends StatelessWidget {
  final bool showEdit;
  const ProjectDetailsBasicInfo({super.key, this.showEdit = true});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectDetailsService>(builder: (context, pd, child) {
      final avgRating =
          pd.projectDetailsModel.projectDetails?.ratingsAvgRating ?? 0;
      final ratingCount =
          pd.projectDetailsModel.projectDetails?.ratingsCount ?? 0;
      final orderCount =
          pd.projectDetailsModel.projectDetails?.completeOrdersCount ?? 0;
      return Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.dProvider.whiteColor),
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
                      imageUrl:
                          "${pd.projectDetailsModel.projectImagePath}/${pd.projectDetailsModel.projectDetails?.image ?? ""}",
                      placeholder: (context, url) =>
                          const ImagePLWidget(size: 60),
                      errorWidget: (context, url, error) =>
                          const ImagePLWidget(size: 60),
                    ),
                  ),
                ),
                if (pd.projectDetailsModel.projectDetails?.status.toString() ==
                    "0")
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
                        if (ratingCount > 0) ...[
                          Icon(
                            Icons.star_rounded,
                            color: context.dProvider.yellowColor,
                            size: 20,
                          ),
                          4.toWidth
                        ],
                        Text(
                          ratingCount > 0
                              ? "$avgRating ($ratingCount)"
                              : LocalKeys.noReview,
                          style: context.titleSmall
                              ?.copyWith(color: context.dProvider.yellowColor)
                              .bold6,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: context.dProvider.black8,
                      )),
                  child: Text(
                    orderCount > 0
                        ? "$orderCount ${LocalKeys.orderInQueue}"
                        : LocalKeys.noOrder,
                    style: context.bodySmall
                        ?.copyWith(color: context.dProvider.black5)
                        .bold6,
                  ),
                ),
              ],
            ),
            20.toHeight,
            Text(pd.projectDetailsModel.projectDetails?.title ?? "---",
                style: context.titleMedium?.bold6),
            8.toHeight,
            HtmlWidget(
              pd.projectDetailsModel.projectDetails?.description ?? "---",
              // style: context.titleSmall
              //     ?.copyWith(color: context.dProvider.black5)
            ),
            16.toHeight,
            // Divider(
            //   color: context.dProvider.black8,
            //   thickness: 2,
            //   // height: 36,
            // ),
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
                    value:
                        pd.projectDetailsModel.projectDetails?.projectOnOff ==
                            "1",
                    onChanged: !showEdit
                        ? null
                        : (value) {
                            ProjectDetailsViewModel.instance
                                .tryProjectStatusChange(context);
                          },
                  ),
                ),
              ],
            ),
            if (showEdit) 20.toHeight,
            if (showEdit) const ProjectDetailsButtons(),
          ],
        ),
      );
    });
  }
}
