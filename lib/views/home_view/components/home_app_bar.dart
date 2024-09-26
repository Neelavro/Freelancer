import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/services/job_list_service.dart.dart';
import 'package:xilancer/services/profile_info_service.dart';
import 'package:xilancer/utils/components/profile_avatar_text.dart';
import 'package:xilancer/view_models/home_drawer_view_model/home_drawer_view_model.dart';
import 'package:xilancer/view_models/home_view_model/home_view_model.dart';

import '../../../helper/svg_assets.dart';
import '../../../view_models/onboarding_view_model/onboarding_view_model.dart';
import '/helper/extension/context_extension.dart';
import '../../../utils/components/empty_spacer_helper.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ov = OnboardingViewModel.instance;
    return Container(
      height: 56 + context.paddingTop,
      color: context.dProvider.whiteColor,
      padding: EdgeInsets.only(top: context.paddingTop),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        EmptySpaceHelper.emptyWidth(24),
        InkWell(
          onTap: () {
            final jl = Provider.of<JobListService>(context, listen: false);
            final hdm = HomeDrawerViewModel.instance;
            hdm.setValues(jl.country, jl.experience, jl.length, jl.maxPrice,
                jl.minPrice, jl.category, jl.subCat);
            debugPrint("opening filter drawer".toString());
            ov.scaffoldKey.currentState?.openDrawer();
          },
          child: Container(
            height: 36,
            width: 32,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.dProvider.black8),
            ),
            child: SvgAssets.filter.toSVG,
          ),
        ),
        const Spacer(),
        Consumer<ProfileInfoService>(builder: (context, pi, child) {
          return pi.profileInfoModel.data == null
              ? CircleAvatar(
                  backgroundColor: context.dProvider.primaryColor,
                  child: SvgAssets.userBold.toSVGSized(
                    18,
                    color: context.dProvider.whiteColor,
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: context.dProvider.primaryColor,
                      shape: BoxShape.circle),
                  child: SizedBox(
                    height: 36,
                    width: 36,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: pi.profileInfoModel.data?.image ?? "",
                        placeholder: (context, url) {
                          return ProfileAvatarText(
                              profileName:
                                  pi.profileInfoModel.data?.firstName ?? "FR");
                        },
                        errorWidget: (context, url, error) {
                          return ProfileAvatarText(
                              profileName:
                                  pi.profileInfoModel.data?.firstName ?? "FR");
                        },
                      ),
                    ),
                  ),
                );
        }),
        EmptySpaceHelper.emptyWidth(24),
      ]),
    );
  }
}
