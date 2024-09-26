import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_network_image.dart';

import '../../fixed_price_job_details_view/fixed_price_job_details_view.dart';

class ProjectBubble extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final bool senderFromWeb;
  final dynamic type;
  final dynamic id;
  const ProjectBubble({
    super.key,
    required this.title,
    this.imageUrl,
    this.id,
    this.type,
    required this.senderFromWeb,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == "job") {
          context.toNamed(FixedPriceJobDetailsView.routeName,
              arguments: [id, title]);
        }
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: context.width - 84),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(12),
            bottomRight: const Radius.circular(12),
            topRight: senderFromWeb
                ? const Radius.circular(12)
                : const Radius.circular(0),
            topLeft: senderFromWeb
                ? const Radius.circular(0)
                : const Radius.circular(12),
          ),
          color: context.dProvider.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              CustomNetworkImage(
                height: 134,
                width: double.infinity,
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                radius: 12.0,
              ),
            if (type == "job")
              Text(
                LocalKeys.jobTitle,
                style: context.bodySmall,
              ),
            4.toHeight,
            Text(
              title,
              style: context.titleMedium
                  ?.copyWith(color: context.dProvider.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
