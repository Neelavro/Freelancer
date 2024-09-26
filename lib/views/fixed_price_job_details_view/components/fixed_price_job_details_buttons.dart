import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/job_details_service.dart';
import 'package:xilancer/services/profile_info_service.dart';
import 'package:xilancer/views/fixed_price_job_details_view/components/apply_job_plain_sheet.dart';
import 'package:xilancer/views/fixed_price_job_details_view/components/job_details_download_attachment_button.dart';
import 'package:xilancer/views/profile_view/components/profile_info.dart';

import '../../../helper/pusher_helper.dart';
import '../../../helper/svg_assets.dart';
import '../../../view_models/fix_price_job_details_view_model/fix_price_job_details_view_model.dart';
import '../../../view_models/sign_in_view/sign_in_view_model.dart';
import '../../../view_models/sign_up_view/sign_up_view_model.dart';
import '../../conversation_view/components/send_offer_sheet.dart';
import '../../sign_in_view/sign_in_view.dart';

class FixedPriceJobDetailsButtons extends StatelessWidget {
  const FixedPriceJobDetailsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<JobDetailsService>(builder: (context, jd, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.toHeight,
          Consumer<ProfileInfoService>(builder: (context, pi, child) {
            return pi.profileInfoModel.data == null
                ? SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          SignInViewModel.instance.initSavedInfo();
                          SignUpViewModel.dispose;
                          context.toNamed(SignInView.routeName);
                        },
                        icon: SvgAssets.user.toSVGSized(20,
                            color: context.dProvider.whiteColor),
                        label: Text(LocalKeys.signIn)),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                        onPressed: jd.jobDetailsModel.alreadyApplied == true
                            ? () {
                                LocalKeys.youCannotApplyToAJobMultipleTimes
                                    .showToast();
                              }
                            : () {
                                FixPriceJobDetailsViewModel.dispose;
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  isDismissible: false,
                                  isScrollControlled: true,
                                  builder: (context) =>
                                      const ApplyJobPlainSheet(),
                                );
                              },
                        icon: SvgAssets.send
                            .toSVGSized(24, color: context.dProvider.black6),
                        label: Text(jd.jobDetailsModel.alreadyApplied == true
                            ? LocalKeys.alreadyProposed
                            : LocalKeys.sendProposal)),
                  );
          }),
          8.toHeight,
          JobDetailsDownloadAttachmentButton(
            attachment: jd.jobDetailsModel.jobDetails?.attachment,
            attachmentPath: jd.jobDetailsModel.attachmentPath,
          ),
        ],
      );
    });
  }
}
