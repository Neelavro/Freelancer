import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/view_models/create_project_view_model/create_project_view_model.dart';

import '../../../customizations.dart';
import '../../../helper/svg_assets.dart';
import '../../../utils/components/image_pl_widget.dart';
import 'create_project_buttons.dart';

class ProjectGallery extends StatelessWidget {
  const ProjectGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final cpm = CreateProjectViewModel.instance;
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalKeys.projectGalleryUpload,
              style: context.titleMedium?.bold6,
            ).hp20,
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 24,
            ),
            ValueListenableBuilder(
                valueListenable: cpm.projectImage,
                builder: (context, image, child) {
                  return GestureDetector(
                    onTap: () {
                      cpm.selectImage();
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: (context.width - 72) * 0.54237,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.dProvider.black9,
                          ),
                          child: (image ?? cpm.oldImage) != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: (image == null
                                      ? CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "$projectImagePath/${cpm.oldImage ?? ""}",
                                          placeholder: (context, url) =>
                                              const ImagePLWidget(size: 60),
                                          errorWidget: (context, url, error) =>
                                              const ImagePLWidget(size: 60),
                                        )
                                      : Image.file(
                                          image,
                                          fit: BoxFit.cover,
                                        )),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgAssets.gallery.toSVGSized(20,
                                        color: context.dProvider.black5),
                                    6.toWidth,
                                    Text(
                                      LocalKeys.selectPhoto,
                                      style: context.titleSmall?.bold.copyWith(
                                          color: context.dProvider.black5),
                                    ),
                                  ],
                                ),
                        ).hp20,
                        if ((image ?? cpm.oldImage) != null)
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 44, vertical: 20),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.dProvider.whiteColor,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                if (image == null) {
                                  cpm.selectImage();
                                }
                                cpm.projectImage.value = null;
                              },
                              child: image == null
                                  ? SvgAssets.gallery.toSVG
                                  : SvgAssets.trash.toSVGSized(
                                      24,
                                      color: context.dProvider.warningColor,
                                    ),
                            ),
                          )
                      ],
                    ),
                  );
                }),
            20.toHeight,
            Text(
              LocalKeys.recommendedProjectGalleryDimension,
              style:
                  context.titleSmall?.copyWith(color: context.dProvider.black5),
            ).hp20,
            20.toHeight,
            const CreateProjectButtons().hp20,
          ],
        ),
      ),
    );
  }
}
