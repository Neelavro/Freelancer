import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/models/subscription_type_model.dart';
import 'package:xilancer/services/subscription_list_service.dart';

class SubscriptionTypesSelect extends StatelessWidget {
  final ValueNotifier<SubscriptionType?> subscriptionTypeNotifier;
  final onChanged;
  final String hintText;
  const SubscriptionTypesSelect({
    super.key,
    required this.subscriptionTypeNotifier,
    required this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionListService>(builder: (context, sl, child) {
      return ValueListenableBuilder(
        valueListenable: subscriptionTypeNotifier,
        builder: (context, ss, child) {
          return FutureBuilder(
              future: sl.subscriptionTypesModel.subscriptionTypes != null
                  ? null
                  : sl.fetchSubscriptionTypes(),
              builder: (context, snapShot) {
                return ConnectionState.waiting == snapShot.connectionState
                    ? const SizedBox()
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        color: context.dProvider.whiteColor,
                        child: Container(
                          height: 46,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: context.dProvider.black8,
                              width: 1,
                            ),
                          ),
                          child: DropdownButton(
                            borderRadius: BorderRadius.circular(8),
                            dropdownColor: context.dProvider.whiteColor,
                            hint: Text(
                              hintText,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: context.dProvider.black5,
                                    fontSize: 14,
                                  ),
                            ),
                            underline: Container(),
                            isExpanded: true,
                            isDense: true,
                            value: ss,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: context.dProvider.black5,
                                  fontSize: 14,
                                ),
                            icon: Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: context.dProvider.black5,
                            ),
                            onChanged: (newType) {
                              subscriptionTypeNotifier.value = newType;
                              if (onChanged != null) {
                                onChanged(newType);
                              }
                            },
                            items:
                                (sl.subscriptionTypesModel.subscriptionTypes ??
                                        [])
                                    .map((SubscriptionType value) {
                              return DropdownMenuItem(
                                alignment: context.dProvider.currencyRight
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                value: value,
                                child: SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      value.type,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
              });
        },
      );
    });
  }
}
