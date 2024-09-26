import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/my_proposals_service.dart';
import 'package:xilancer/view_models/my_proposals_view_model/my_proposals_view_model.dart';
import 'package:xilancer/views/my_proposals_view/components/my_proposal_card.dart';

import '../../utils/components/custom_future_widget.dart';
import '../../utils/components/custom_preloader.dart';
import '../../utils/components/custom_refresh_indicator.dart';
import '../../utils/components/empty_widget.dart';
import 'components/my_proposal_skeleton.dart';

class MyProposalsView extends StatelessWidget {
  static const routeName = "my_proposals_view";
  const MyProposalsView({super.key});

  @override
  Widget build(BuildContext context) {
    final mom = MyProposalsViewModel.instance;
    final olProvider = Provider.of<MyProposalsService>(context, listen: false);
    mom.scrollController.addListener(() {
      mom.tryToLoadMore(context);
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(LocalKeys.myProposals),
        ),
        body: CustomRefreshIndicator(
          onRefresh: () async {
            await olProvider.fetchOrderList();
          },
          child: CustomFutureWidget(
              function: olProvider.shouldAutoFetch
                  ? olProvider.fetchOrderList()
                  : null,
              shimmer: const MyProposalsSkeleton(),
              child:
                  Consumer<MyProposalsService>(builder: (context, mo, child) {
                return Scrollbar(
                  controller: mom.scrollController,
                  child: mo.proposalList?.isEmpty != false
                      ? EmptyWidget(title: LocalKeys.noOrderYet)
                      : ListView.separated(
                          controller: mom.scrollController,
                          padding: const EdgeInsets.all(20),
                          itemBuilder: (context, index) {
                            if (mo.nextPage != null &&
                                mo.proposalList!.length == (index)) {
                              return const CustomPreloader();
                            }

                            final proposalItem = mo.proposalList![index];
                            return MyProposalCard(
                              id: proposalItem.id,
                              budget: proposalItem.amount ?? 0,
                              deadline: proposalItem.duration,
                              isSeen: proposalItem.isView,
                              isRejected: proposalItem.isRejected,
                              isInterviewed: proposalItem.isInterviewTake,
                              isShortListed: proposalItem.isShortListed,
                              createdAt: proposalItem.createdAt,
                              description: proposalItem.coverLetter,
                              jobTitle: proposalItem.job?.title,
                              attachment: (proposalItem.attachment ?? "")
                                      .isNotEmpty
                                  ? "${mo.myProposalsModel.myProposals!.path}/${proposalItem.attachment}"
                                  : null,
                            );
                          },
                          separatorBuilder: (context, index) => 16.toHeight,
                          itemCount: mo.proposalList!.length +
                              (mo.nextPage != null && !mo.nexLoadingFailed
                                  ? 1
                                  : 0)),
                );
              })),
        ));
  }
}
