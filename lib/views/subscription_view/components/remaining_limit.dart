import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/subscription_history_service.dart';

import '../../subscription_store_view/subscription_store_view.dart';

class RemainingLimit extends StatelessWidget {
  const RemainingLimit({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: context.dProvider.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Consumer<SubscriptionHistoryService>(
                builder: (context, sh, child) {
              return RichText(
                  text: TextSpan(
                      text: "${LocalKeys.remainingLimit}: ",
                      style: context.titleMedium
                          ?.copyWith(color: context.dProvider.black5),
                      children: [
                    TextSpan(
                        text: sh.subscriptionHistoryModel.totalLimit
                            .toString()
                            .tryToParse
                            .toStringAsFixed(0),
                        style: context.titleLarge?.bold6),
                    // TextSpan(
                    //     text: "/week",
                    //     style: context.titleSmall
                    //         ?.copyWith(color: context.dProvider.black5)),
                  ]));
            }),
          ),
          IconButton(
              onPressed: () {
                context.toNamed(SubscriptionStoreView.routeName);
              },
              icon: const Icon(Icons.add_circle_outline_rounded))
        ],
      ),
    );
  }
}
