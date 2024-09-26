import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/services/subscription_list_service.dart';

import '../../models/subscription_type_model.dart';

class SubscriptionStoreViewModel {
  ScrollController scrollController = ScrollController();
  ValueNotifier<SubscriptionType?> subscriptionTypeNotifier =
      ValueNotifier(null);

  SubscriptionStoreViewModel._init();
  static SubscriptionStoreViewModel? _instance;
  static SubscriptionStoreViewModel get instance {
    _instance ??= SubscriptionStoreViewModel._init();
    return _instance!;
  }

  static bool get dispose {
    _instance = null;
    return true;
  }

  tryToLoadMore(BuildContext context) {
    try {
      final slProvider =
          Provider.of<SubscriptionListService>(context, listen: false);
      final nextPage = slProvider.nextPage;
      final nextPageLoading = slProvider.nextPageLoading;

      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (nextPage != null && !nextPageLoading) {
          slProvider.fetchNextPage();
          return;
        }
      }
    } catch (e) {}
  }
}
