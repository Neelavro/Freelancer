import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/services/profile_details_service.dart';
import 'package:xilancer/view_models/profile_details_view_model/profile_details_view_model.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_location.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_time.dart';

import '../../../helper/local_keys.g.dart';
import 'profile_name_infos.dart';

class ProfileDetailsBasicInfo extends StatelessWidget {
  const ProfileDetailsBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileDetailsService>(builder: (context, pd, child) {
      final user = pd.profileDetails.user;
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileNameInfos(),
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 36,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocalKeys.availableForWork,
                  style: context.titleMedium?.bold6,
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: user?.checkWorkAvailability.toString() == "1",
                    onChanged: (value) {
                      ProfileDetailsViewModel.instance
                          .tryChangingStatus(context);
                    },
                  ),
                ),
              ],
            ),
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 36,
            ),
            // ...[
            //   ProfileDetailsPrice(pd: pd),
            //   Divider(
            //     color: context.dProvider.black8,
            //     thickness: 2,
            //     height: 36,
            //   )
            // ],
            ProfileDetailsLocation(
              pd: pd,
            ),
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 36,
            ),
            ProfileDetailsTime(pd: pd),
            if (user?.userIntroduction?.description != null) ...[
              Divider(
                color: context.dProvider.black8,
                thickness: 2,
                height: 36,
              ),
              Text(
                LocalKeys.aboutMe,
                style: context.titleMedium?.bold6,
              ),
              8.toHeight,
              Text(user!.userIntroduction!.description!,
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.black5))
            ]
          ],
        ),
      );
    });
  }
}
