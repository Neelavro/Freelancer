import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/view_models/subscription_buy_view_model/subscription_buy_view_model.dart';

import '../../helper/local_keys.g.dart';
import '../../utils/components/field_label.dart';
import '../payment_views/payment_gateways.dart';

class SubscriptionBuyView extends StatelessWidget {
  const SubscriptionBuyView({super.key});

  @override
  Widget build(BuildContext context) {
    final sbm = SubscriptionBuyViewModel.instance;
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationPopIcon(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.dProvider.whiteColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder(
                valueListenable: sbm.walletSelect,
                builder: (context, ws, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        value: ws,
                        onChanged: (value) {
                          sbm.walletSelect.value = !ws;
                        },
                        title: Text(LocalKeys.useWalletBallance),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      if (!ws) ...[
                        FieldLabel(label: LocalKeys.selectAPaymentMethod),
                        PaymentGateways(
                          gatewayNotifier: sbm.selectedGateway,
                          attachmentNotifier: sbm.selectedAttachment,
                          cardController: sbm.aCardController,
                          secretCodeController: sbm.authCodeController,
                          zUsernameController: sbm.zUsernameController,
                          expireDateNotifier: sbm.authNetExpireDate,
                          usernameController: TextEditingController(),
                        ),
                      ],
                      16.toHeight,
                      ValueListenableBuilder(
                        valueListenable: sbm.isLoading,
                        builder: (context, loading, child) {
                          return CustomButton(
                            onPressed: () {
                              sbm.trySubscriptionBuy(context);
                            },
                            btText: LocalKeys.buySubscription,
                            isLoading: loading,
                          );
                        },
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
