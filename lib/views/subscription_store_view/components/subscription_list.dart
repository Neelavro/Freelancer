import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/subscription_list_service.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';
import 'package:xilancer/utils/components/empty_widget.dart';

import '../../../utils/components/scrolling_preloader.dart';
import '../../../view_models/subscription_store_view_model/subscription_store_view_model.dart';
import 'subscription_card.dart';

class SubscriptionList extends StatelessWidget {
  const SubscriptionList({super.key});

  @override
  Widget build(BuildContext context) {
    final ssm = SubscriptionStoreViewModel.instance;
    ssm.scrollController.addListener(() {
      ssm.tryToLoadMore(context);
    });
    return Consumer<SubscriptionListService>(builder: (context, sl, child) {
      return CustomFutureWidget(
          function: sl.shouldAutoFetch ? sl.fetchSubscriptionList() : null,
          shimmer: const CustomPreloader(),
          isLoading: sl.isLoading,
          child: Expanded(
            child: (sl.subscriptionListModel.subscriptionsData?.subscriptions
                        ?.isEmpty ??
                    true)
                ? EmptyWidget(title: LocalKeys.noSubscriptionsFound)
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    controller: ssm.scrollController,
                    itemBuilder: (context, index) {
                      if (sl.nextPage != null &&
                          (sl.subscriptionListModel.subscriptionsData!
                                      .subscriptions!.length +
                                  0) ==
                              (index)) {
                        return ScrollPreloader(
                          loading: sl.nextPageLoading,
                        );
                      }
                      final subsItem = sl.subscriptionListModel
                          .subscriptionsData!.subscriptions![index];
                      return SubscriptionCard(
                        id: subsItem.id,
                        title: subsItem.title ?? "---",
                        price: subsItem.price,
                        type: subsItem.subscriptionType?.type ?? "---",
                        imageUrl: subsItem.logo,
                        limit: subsItem.limit,
                        features: subsItem.features ?? [],
                      );
                    },
                    separatorBuilder: (context, index) => 12.toHeight,
                    itemCount: sl.subscriptionListModel.subscriptionsData!
                            .subscriptions!.length +
                        (sl.nextPage != null && !sl.nexLoadingFailed ? 1 : 0)),
          ));
    });
  }
}
