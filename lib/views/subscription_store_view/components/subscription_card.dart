import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/image_assets.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/view_models/subscription_buy_view_model/subscription_buy_view_model.dart';
import 'package:xilancer/views/chat_list_view/components/chat_tile_avatar.dart';
import 'package:xilancer/views/subscription_buy_view/subscription_buy_view.dart';

import '../../../models/subscription_list_model.dart';
// import 'package:xilancer/views/payment_chose_view/payment_chose_view.dart';

class SubscriptionCard extends StatelessWidget {
  final dynamic id;
  final String title;
  final num limit;
  final String? imageUrl;
  final num price;
  final String type;
  final List<Feature> features;
  const SubscriptionCard(
      {super.key,
      required this.id,
      required this.title,
      this.imageUrl,
      required this.price,
      required this.type,
      required this.features,
      required this.limit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: context.dProvider.whiteColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          child: Row(
            children: [
              const ChatTileAvatar(
                size: 36,
                name: "",
                placeHolderImage: ImageAssets.loadingImage,
              ),
              12.toWidth,
              RichText(
                  text: TextSpan(
                      text: title,
                      style: context.titleLarge?.bold6,
                      children: [
                    TextSpan(
                      text: ' /$limit',
                      style: context.titleMedium
                          ?.copyWith(color: context.dProvider.black5),
                    )
                  ]))
            ],
          ),
        ),
        2.toHeight,
        ...features.map((e) => Container(
              color: context.dProvider.whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    e.status ? Icons.done_rounded : Icons.close_rounded,
                    color: e.status
                        ? context.dProvider.greenColor
                        : context.dProvider.warningColor,
                    size: 20,
                  ),
                  12.toWidth,
                  Text(
                    e.feature ?? "---",
                    style: context.titleSmall
                        ?.copyWith(color: context.dProvider.black5),
                  ),
                ],
              ),
            )),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: context.dProvider.whiteColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: price.toStringAsFixed(2).cur,
                      style: context.titleLarge?.bold6,
                      children: [
                    TextSpan(
                      text: ' /$type',
                      style: context.titleMedium
                          ?.copyWith(color: context.dProvider.black5),
                    )
                  ])),
              12.toHeight,
              CustomButton(
                  onPressed: () {
                    SubscriptionBuyViewModel.dispose;
                    SubscriptionBuyViewModel.instance.setSubId(id);
                    context.toPage(const SubscriptionBuyView());
                  },
                  btText: LocalKeys.purchasePlan.capitalizeWords,
                  isLoading: false)
            ],
          ),
        ),
      ],
    );
  }
}
