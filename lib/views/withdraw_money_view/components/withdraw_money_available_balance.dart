import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import 'withdraw_money_sheet.dart';

class WithdrawMoneyAvailableBalance extends StatelessWidget {
  const WithdrawMoneyAvailableBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.dProvider.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalKeys.availableBalance,
            style:
                context.titleSmall?.copyWith(color: context.dProvider.black5),
          ),
          8.toHeight,
          Text(
            236541254.214.toStringAsFixed(2).cur,
            style: context.titleLarge?.bold6
                .copyWith(color: context.dProvider.primaryColor),
          ),
          32.toHeight,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) => const WithdrawMoneySheet(),
                );
              },
              child: Text(LocalKeys.withdrawMoney),
            ),
          )
        ],
      ),
    );
  }
}
