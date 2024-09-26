import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/subscription_history_service.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/custom_refresh_indicator.dart';
import 'package:xilancer/utils/components/empty_widget.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/utils/components/scrolling_preloader.dart';
import 'package:xilancer/view_models/subscription_view_model/subscription_view_model.dart';
import 'package:xilancer/views/subscription_view/components/remaining_limit.dart';
import 'package:xilancer/views/subscription_view/components/subscription_history.dart';
import 'package:xilancer/views/subscription_view/components/subscription_history_tile.dart';

import 'components/subscription_history_skeleton.dart';

class SubscriptionView extends StatelessWidget {
  static const routeName = 'subscription_view';
  const SubscriptionView({super.key});
  @override
  Widget build(BuildContext context) {
    final shProvider =
        Provider.of<SubscriptionHistoryService>(context, listen: false);
    final shm = SubscriptionViewModel.instance;
    shm.scrollController.addListener(() {
      shm.tryToLoadMore(context);
    });
    return Scaffold(
        appBar: AppBar(
          leading: const NavigationPopIcon(),
          title: Text(LocalKeys.subscription),
        ),
        body: CustomRefreshIndicator(
          onRefresh: () async {
            await shProvider.fetchSubscriptionHistory();
          },
          child: CustomFutureWidget(
            function: shProvider.shouldAutoFetch
                ? shProvider.fetchSubscriptionHistory()
                : null,
            shimmer: const SubsHistorySkeleton(),
            child: Consumer<SubscriptionHistoryService>(
                builder: (context, sh, child) {
              final listLength = sh.subscriptionHistoryModel.allSubscriptions
                      ?.history?.length ??
                  0;
              return Scrollbar(
                child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    controller: shm.scrollController,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Column(
                            children: [
                              const RemainingLimit(),
                              18.toHeight,
                            ],
                          );
                        case 1:
                          return const SubscriptionHistory();
                        default:
                      }
                      final length = listLength + 2;
                      if (listLength == 0) {
                        return SizedBox(
                            height: context.height / 1.58,
                            child: EmptyWidget(
                              title: LocalKeys.noHistoryFound,
                              margin: EdgeInsets.zero,
                            ));
                      }
                      if (sh.nextPage != null && (length) == index) {
                        return ScrollPreloader(loading: sh.nextPageLoading);
                      }
                      final hItem = sh.subscriptionHistoryModel
                          .allSubscriptions!.history![index - 2];
                      return SubscriptionHistoryTile(
                        limit: hItem.limit.toStringAsFixed(0),
                        type: hItem.userSubscriptionTypeApi?.type ?? "",
                        price: hItem.limit.toStringAsFixed(0),
                        sStatus: hItem.status.toString(),
                        pStatus: hItem.paymentStatus.toString(),
                        eDate: hItem.expireDate ?? DateTime.now(),
                      );
                    },
                    separatorBuilder: (context, index) => 2.toHeight,
                    itemCount: (listLength == 0 ? 1 : listLength) +
                        2 +
                        (sh.nextPage != null && !sh.nexLoadingFailed ? 1 : 0)),
              );
            }),
          ),
        ));
  }
}
