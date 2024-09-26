import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/view_models/my_order_details_view_model/my_order_details_view_model.dart';

import '../../../utils/components/custom_button.dart';

class OrderDetailsButtons extends StatelessWidget {
  final orderAccepted;
  final orderId;
  final bool hideButtons;
  const OrderDetailsButtons({
    super.key,
    required this.orderId,
    this.orderAccepted = false,
    this.hideButtons = false,
  });

  @override
  Widget build(BuildContext context) {
    final modm = MyOrderDetailsViewModel.instance;
    return hideButtons
        ? const SizedBox()
        : Column(
            children: [
              Divider(
                color: context.dProvider.black8,
                thickness: 2,
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  onPressed: () {
                    if (!orderAccepted) {
                      modm.tryDeclineOrder(context, orderId);
                      return;
                    }

                    modm.tryCancelOrder(context, orderId);
                  },
                  btText: orderAccepted
                      ? LocalKeys.cancelOrder
                      : LocalKeys.declineOrder,
                  isLoading: false,
                  backgroundColor: context.dProvider.warningColor,
                ),
              ),
              if (!orderAccepted) 8.toHeight,
              if (!orderAccepted)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        modm.tryAcceptOrder(context, orderId);
                      },
                      child: Text(LocalKeys.acceptOrder)),
                ),
            ],
          ).hp20;
  }
}
