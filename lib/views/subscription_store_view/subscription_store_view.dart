import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/custom_refresh_indicator.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/view_models/subscription_store_view_model/subscription_store_view_model.dart';
import 'package:xilancer/views/subscription_store_view/components/subscription_list.dart';
import 'package:xilancer/views/subscription_store_view/components/subscription_types_select.dart';

import '../../services/subscription_list_service.dart';

class SubscriptionStoreView extends StatelessWidget {
  static const routeName = 'subscription_store_view';
  const SubscriptionStoreView({super.key});
  @override
  Widget build(BuildContext context) {
    final ssm = SubscriptionStoreViewModel.instance;
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationPopIcon(),
        title: Text(LocalKeys.subscription),
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          Provider.of<SubscriptionListService>(context, listen: false)
              .fetchSubscriptionList(refresh: true);
        },
        child: CustomFutureWidget(
            shimmer: Container(),
            child: Column(
              children: [
                2.toHeight,
                SubscriptionTypesSelect(
                    subscriptionTypeNotifier: ssm.subscriptionTypeNotifier,
                    onChanged: (_) {
                      Provider.of<SubscriptionListService>(context,
                              listen: false)
                          .fetchSubscriptionList(
                        filter: true,
                      );
                    },
                    hintText: LocalKeys.all),
                const SubscriptionList(),
              ],
            )),
      ),
      // floatingActionButton: IconButton(
      //     onPressed: () {
      //       Provider.of<SubscriptionListService>(context, listen: false)
      //           .fetchSubscriptionList();
      //     },
      //     icon: const Icon(Icons.add_link_rounded)),
    );
  }
}
