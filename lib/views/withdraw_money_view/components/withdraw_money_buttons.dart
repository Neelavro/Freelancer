import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';

import '../../../helper/local_keys.g.dart';

class WithdrawMoneyButtons extends StatelessWidget {
  const WithdrawMoneyButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 12,
          child: OutlinedButton(
            onPressed: () {},
            child: Text(LocalKeys.cancel),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 20,
          child: ElevatedButton(
            onPressed: () async {
              // final Uri launchUri = Uri(
              //   scheme: 'tel',
              //   path: "4265411254",
              // );
              // await urlLauncher.launchUrl(launchUri);
            },
            child: Text(LocalKeys.withdrawMoney),
          ),
        ),
      ],
    ).hp20;
  }
}
