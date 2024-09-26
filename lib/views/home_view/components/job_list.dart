import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/job_list_service.dart.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/empty_widget.dart';
import 'package:xilancer/view_models/home_view_model/home_view_model.dart';

import '../../../utils/components/custom_preloader.dart';
import 'job_card.dart';
import 'job_card_skeleton.dart';

class JobList extends StatelessWidget {
  final HomeViewModel hvm;
  const JobList({super.key, required this.hvm});

  @override
  Widget build(BuildContext context) {
    hvm.scrollController.addListener(() {
      hvm.tryToLoadMore(context);
    });
    return Expanded(
        child: Consumer<JobListService>(builder: (context, jl, child) {
      return CustomFutureWidget(
          function:
              jl.shouldAutoFetch ? jl.fetchJobList(refreshing: true) : null,
          shimmer: Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.all(20),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const JobCardSkeleton(fromDetails: false);
                },
                separatorBuilder: (context, index) => 16.toHeight,
                itemCount: 20),
          ).shim,
          isLoading: jl.isLoading,
          child: jl.jobList?.isEmpty ?? true == true
              ? EmptyWidget(title: LocalKeys.noJobFound)
              : Scrollbar(
                  controller: hvm.scrollController,
                  child: ListView.separated(
                      padding: const EdgeInsets.all(20),
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: hvm.scrollController,
                      itemBuilder: (context, index) {
                        if ((jl.nextPage != null && !jl.nexLoadingFailed) &&
                            index == jl.jobList!.length) {
                          return const CustomPreloader();
                        }

                        final jobItem = jl.jobList![index];
                        return JobCard(
                            id: jobItem.id,
                            title: jobItem.title,
                            isFavorite: false,
                            createDate: jobItem.createdAt,
                            expertise: jobItem.level.toString().capitalize,
                            price: jobItem.budget,
                            priceType: jobItem.type.toString().capitalize,
                            summery: jobItem.description,
                            tags: jobItem.jobSkills
                                    ?.map((e) => e.skill ?? "")
                                    .toList() ??
                                [],
                            location: jobItem.jobCreator?.userCountry?.country
                                    ?.toString() ??
                                "----",
                            proposalCount: jobItem.jobProposalCount ?? 0,
                            userVerified:
                                jobItem.jobCreator?.userVerifiedStatus ?? false,
                            deadline: jobItem.duration,
                            rating: 4.5);
                      },
                      separatorBuilder: (context, index) => 16.toHeight,
                      itemCount: jl.jobList!.length +
                          (jl.nextPage != null && !jl.nexLoadingFailed
                              ? 1
                              : 0)),
                ));
    }));
  }
}
