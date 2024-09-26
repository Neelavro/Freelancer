import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/services/subscription_history_service.dart';

class SubscriptionViewModel {
  ScrollController scrollController = ScrollController();
  SubscriptionViewModel._init();
  static SubscriptionViewModel? _instance;
  static SubscriptionViewModel get instance {
    _instance ??= SubscriptionViewModel._init();
    return _instance!;
  }

  SubscriptionViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  tryToLoadMore(BuildContext context) {
    try {
      final subs =
          Provider.of<SubscriptionHistoryService>(context, listen: false);
      final nextPage = subs.nextPage;
      final nextPageLoading = subs.nextPageLoading;

      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (nextPage != null && !nextPageLoading) {
          subs.fetchNextPage();
          return;
        }
      }
    } catch (e) {}
  }
}
