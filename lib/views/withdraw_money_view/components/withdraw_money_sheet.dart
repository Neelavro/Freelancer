import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import 'withdraw_money_buttons.dart';
import 'withdraw_sheet_amount.dart';

class WithdrawMoneySheet extends StatelessWidget {
  const WithdrawMoneySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom / 2),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: context.dProvider.whiteColor,
      ),
      constraints: BoxConstraints(
          maxHeight:
              context.height / 2 + (MediaQuery.of(context).viewInsets.bottom)),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 4,
              width: 48,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: context.dProvider.black7,
              ),
            ),
          ),
          8.toHeight,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LocalKeys.withdrawMoney,
                          style: context.titleMedium?.bold6)
                      .hp20,
                  Divider(
                    color: context.dProvider.black8,
                    thickness: 2,
                    height: 36,
                  ),
                  const WithdrawSheetAmount().hp20,
                  // 16.toHeight,
                  // const ExchangeRate(),
                  20.toHeight,
                  const WithdrawMoneyButtons(),
                  30.toHeight
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
