import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/services/profile_details_service.dart';
import 'package:xilancer/views/chat_list_view/components/chat_tile_avatar.dart';

import '../../../helper/local_keys.g.dart';

class ProfileNameInfos extends StatelessWidget {
  const ProfileNameInfos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileDetailsService>(builder: (context, pd, child) {
      final user = pd.profileDetails.user;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: ChatTileAvatar(
                imageUrl:
                    "${pd.profileDetails.profileImagePath}/${user?.image}",
                name: "${user?.firstName ?? ""} ${user?.lastName ?? ""}",
                size: 60.0),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: context.dProvider.greenColor,
                      )),
                  child: FittedBox(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 4,
                          backgroundColor: context.dProvider.greenColor,
                        ),
                        4.toWidth,
                        Text(
                          LocalKeys.active,
                          style: context.titleSmall
                              ?.copyWith(color: context.dProvider.greenColor)
                              .bold6,
                        ),
                      ],
                    ),
                  ),
                ),
                8.toHeight,
                Text(
                  "${user?.firstName ?? ""} ${user?.lastName ?? ""}",
                  style: context.titleMedium?.bold6,
                ),
                if (user?.userIntroduction?.title != null) ...[
                  4.toHeight,
                  Text(
                    user?.userIntroduction?.title ?? "",
                    style: context.titleSmall
                        ?.copyWith(color: context.dProvider.black5),
                  )
                ],
                8.toHeight,
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
                        4.toWidth,
                        Text(
                          "${pd.profileDetails.avgRating ?? 0} (${pd.profileDetails.totalRating ?? 0})",
                          style: context.titleSmall
                              ?.copyWith(color: context.dProvider.yellowColor)
                              .bold6,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
