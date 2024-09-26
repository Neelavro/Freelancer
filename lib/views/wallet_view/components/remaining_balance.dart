import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/helper/svg_assets.dart';
import 'package:xilancer/view_models/wallet_deposit_view_model/wallet_deposit_view_model.dart';
import 'package:xilancer/view_models/withdraw_requests_view_model/withdraw_requests_view_model.dart';
import 'package:xilancer/views/wallet_deposit_view/wallet_deposit_view.dart';
import 'package:xilancer/views/withdraw_money_view/withdraw_money_view.dart';

class RemainingBalance extends StatelessWidget {
  final num amount;
  const RemainingBalance({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: context.dProvider.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: RichText(
                    text: TextSpan(
                        text: "${LocalKeys.balance}: ",
                        style: context.titleMedium
                            ?.copyWith(color: context.dProvider.black5),
                        children: [
                      TextSpan(
                          text: amount.toStringAsFixed(2).cur,
                          style: context.titleLarge?.bold6),
                    ])),
              ),
            ],
          ),
          12.toHeight,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      WalletDepositViewModel.dispose;
                      context.toPage(const WalletDepositView());
                    },
                    label: Text(LocalKeys.deposit),
                    icon: SvgAssets.moneyReceive.toSVGSized(
                      20,
                      color: context.dProvider.black5,
                    ),
                  )),
              12.toWidth,
              Expanded(
                  flex: 1,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      WithdrawRequestsViewModel.dispose;
                      context.toNamed(WithdrawMoneyView.routeName);
                    },
                    label: Text(LocalKeys.withdraw),
                    icon: SvgAssets.moneySend.toSVGSized(
                      20,
                      color: context.dProvider.whiteColor,
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
