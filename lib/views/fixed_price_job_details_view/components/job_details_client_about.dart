import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/job_details_service.dart';

import '../../../helper/image_assets.dart';
import '../../chat_list_view/components/chat_tile_avatar.dart';

class JobDetailsClientAbout extends StatelessWidget {
  const JobDetailsClientAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobDetailsService>(builder: (context, jd, child) {
      if (jd.jobDetailsModel.user == null) {
        return const SizedBox();
      }
      final user = jd.jobDetailsModel.user!;
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalKeys.aboutClient,
              style: context.titleMedium?.bold6,
            ).hp20,
            20.toHeight,
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChatTileAvatar(
                  placeHolderImage: ImageAssets.avatar,
                  name: "",
                  size: 44.0,
                  imageUrl: jd.jobDetailsModel.image.toString(),
                ),
                Text(
                  "${user.firstName ?? ""} ${user.lastName ?? ""}",
                  style: context.titleSmall?.bold6,
                ),
              ],
            ).hp20,
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 16,
            ),
            infos(
                context,
                LocalKeys.memberSince,
                DateFormat("MMM dd, yyyy", dProvider.languageSlug)
                    .format(user.createdAt ?? DateTime.now())),
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 16,
            ),
            infos(
                context, LocalKeys.country, user.userCountry?.country ?? "---"),
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 16,
            ),
            infos(context, LocalKeys.clientTotalJob, user.userJobCount),
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 16,
            ),
            infos(context, LocalKeys.hireRate, jd.jobDetailsModel.hiringRate),
          ],
        ),
      );
    });
  }

  infos(BuildContext context, title, desc) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: context.titleSmall?.black5,
          )),
          Expanded(
              child: Text(
            desc,
            textAlign: TextAlign.end,
            style: context.titleSmall?.bold6,
          ))
        ],
      ).hp20,
    );
  }
}
