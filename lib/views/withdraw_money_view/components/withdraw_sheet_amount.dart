import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/field_label.dart';

import '../../../utils/components/custom_dropdown.dart';

class WithdrawSheetAmount extends StatelessWidget {
  const WithdrawSheetAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label: LocalKeys.withdrawMethod),
        CustomDropdown("", const ['f', "b"], (value) {}),
        16.toHeight,
        FieldLabel(label: LocalKeys.enterAmount),
        TextFormField(
          decoration: InputDecoration(
              hintText: LocalKeys.enterAmount.capitalize,
              prefixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border(
                          left: context.dProvider.textDirectionRight
                              ? BorderSide(
                                  color: context.dProvider.black7,
                                )
                              : BorderSide.none,
                          right: context.dProvider.textDirectionRight
                              ? BorderSide.none
                              : BorderSide(
                                  color: context.dProvider.black7,
                                )),
                    ),
                    child: Text(
                      context.dProvider.currencySymbol,
                      style: context.titleLarge
                          ?.copyWith(color: context.dProvider.primaryColor)
                          .bold6,
                    ),
                  ),
                ],
              )),
        ),
        16.toHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const FieldLabel(label: "LocalKeys.withdrawFee"),
            Text(
              "2".cur,
              style: context.titleMedium?.bold6,
            ),
          ],
        ),
        16.toHeight,
        Divider(
          color: context.dProvider.black8,
          thickness: 2,
          height: 36,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FieldLabel(label: LocalKeys.youWillGet),
            Text(
              "232".cur,
              style: context.titleMedium?.bold6,
            ),
          ],
        ),
      ],
    );
  }
}
