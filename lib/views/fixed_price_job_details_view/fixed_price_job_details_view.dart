import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/job_details_service.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/custom_refresh_indicator.dart';
import 'package:xilancer/utils/components/empty_widget.dart';
import 'package:xilancer/views/home_view/components/job_card.dart';

import '/helper/extension/context_extension.dart';
import '/helper/extension/int_extension.dart';
import '/helper/extension/widget_extension.dart';
import '/utils/components/navigation_pop_icon.dart';
import 'components/fixed_price_job_details_buttons.dart';
import 'components/job_details_client_about.dart';
import 'components/job_details_view_skeleton.dart';

class FixedPriceJobDetailsView extends StatelessWidget {
  static const routeName = 'fixed_price_job_details_view';
  const FixedPriceJobDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final jdProvider = Provider.of<JobDetailsService>(context, listen: false);
    final arguments = ModalRoute.of(context)?.settings.arguments as List;
    final jobId = arguments[0];
    final jobTitle = arguments[1];
    return Scaffold(
        appBar:
            AppBar(leading: const NavigationPopIcon(), title: Text(jobTitle)),
        body: CustomRefreshIndicator(
          onRefresh: () async {
            await jdProvider.fetchOrderDetails(jobId: jobId, refresh: true);
          },
          child: CustomFutureWidget(
              function: jdProvider.shouldAutoFetch(jobId.toString())
                  ? jdProvider.fetchOrderDetails(jobId: jobId)
                  : null,
              shimmer: const JobDetailsSkeleton(),
              child: Consumer<JobDetailsService>(builder: (context, jd, child) {
                if (jd.jobDetailsModel.jobDetails == null) {
                  return EmptyWidget(title: LocalKeys.jobDetailsNotFound);
                }
                final jobDetails = jd.jobDetailsModel.jobDetails!;

                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.dProvider.whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          JobCard(
                            id: jobDetails.id,
                            title: jobDetails.title,
                            isFavorite: false,
                            createDate: jobDetails.createdAt,
                            expertise: jobDetails.level.toString().capitalize,
                            price: jobDetails.budget,
                            priceType: jobDetails.type.toString().capitalize,
                            summery: jobDetails.description,
                            tags: jobDetails.jobSkills
                                    ?.map((e) => e.skill ?? "")
                                    .toList() ??
                                [],
                            location: jd
                                    .jobDetailsModel.user?.userCountry?.country
                                    ?.toString() ??
                                "----",
                            proposalCount: jobDetails.jobProposals?.length ?? 0,
                            userVerified:
                                jd.jobDetailsModel.user?.userVerifiedStatus ??
                                    false,
                            rating: 4.5,
                            fromDetails: true,
                            deadline: jobDetails.duration,
                          ),
                          const FixedPriceJobDetailsButtons().hp20
                        ],
                      ),
                    ),
                    20.toHeight,
                    const JobDetailsClientAbout(),
                  ],
                );
              })),
        ));
  }
}
