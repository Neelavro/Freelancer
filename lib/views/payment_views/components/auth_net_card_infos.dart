import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/field_with_label.dart';
import 'package:xilancer/utils/components/select_date_fl.dart';

class AuthCardInfos extends StatelessWidget {
  final TextEditingController cardController;
  final TextEditingController usernameController;
  final TextEditingController secretCodeController;
  final ValueNotifier<DateTime?> expireDateNotifier;
  const AuthCardInfos({
    super.key,
    required this.cardController,
    required this.usernameController,
    required this.secretCodeController,
    required this.expireDateNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldWithLabel(
          label: LocalKeys.cardNumber,
          hintText: "0000 0000 0000 0000",
          controller: cardController,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value.toString().length < 16) {
              return LocalKeys.invalidCardNumber;
            }
            return null;
          },
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: FieldWithLabel(
                label: LocalKeys.cvvCvc,
                hintText: "123",
                controller: secretCodeController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.toString().length < 16) {
                    return LocalKeys.invalidCardNumber;
                  }
                  return null;
                },
              ),
            ),
            16.toWidth,
            Expanded(
              flex: 1,
              child: ValueListenableBuilder(
                valueListenable: expireDateNotifier,
                builder: (context, date, child) {
                  return SelectDateFL(
                    title: LocalKeys.expireDate,
                    value: date,
                    onChanged: (value) {
                      expireDateNotifier.value = value;
                    },
                  );
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
