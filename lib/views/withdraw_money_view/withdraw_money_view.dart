import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/withdraw_request_service.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/utils/components/custom_dropdown.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';
import 'package:xilancer/utils/components/field_label.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/view_models/withdraw_requests_view_model/withdraw_requests_view_model.dart';

import '../../utils/components/field_with_label.dart';
import '../conversation_view/components/send_offer_sheet.dart';
import 'components/balance_box.dart';

class WithdrawMoneyView extends StatelessWidget {
  static const routeName = 'withdraw_money_view';
  const WithdrawMoneyView({super.key});
  @override
  Widget build(BuildContext context) {
    final wrm = WithdrawRequestsViewModel.instance;
    final wrProvider =
        Provider.of<WithdrawRequestService>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          leading: const NavigationPopIcon(),
          title: Text(LocalKeys.withdrawMoney),
        ),
        body: CustomFutureWidget(
          function: wrProvider.shouldAutoFetch
              ? wrProvider.fetchWithdrawSettings()
              : null,
          shimmer: const CustomPreloader(),
          child:
              Consumer<WithdrawRequestService>(builder: (context, wr, child) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                BalanceBox(
                    balance:
                        wr.withdrawSettingsModel.userCurrentBalance.balance),
                2.toHeight,
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  color: context.dProvider.whiteColor,
                  child: Form(
                    key: wrm.formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              LocalKeys.withdrawTo,
                              style: context.titleMedium?.bold6
                                  .copyWith(color: context.dProvider.black5),
                            ),
                          ),
                          FieldLabel(
                            label: LocalKeys.amount,
                            isRequired: true,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: wrm.amountController,
                            decoration: InputDecoration(
                              prefixIcon: const CurrencyPrefix(),
                              hintText: LocalKeys.enterAmount,
                            ),
                            validator: (value) {
                              if ((num.tryParse(value.toString()) ?? 0) < 1) {
                                return LocalKeys.enterValidAmount;
                              }
                              return null;
                            },
                          ),
                          16.toHeight,
                          FieldLabel(
                            label: LocalKeys.withdrawMethod,
                            isRequired: true,
                          ),
                          ValueListenableBuilder(
                            valueListenable: wrm.selectedGateway,
                            builder: (context, gateway, child) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomDropdown(
                                    LocalKeys.selectAPaymentMethod,
                                    wr.withdrawSettingsModel.withdrawGateways
                                        .map((e) => e.name)
                                        .toList(),
                                    (value) {
                                      wrm.setSelectedGateway(context, value);
                                    },
                                    value: gateway?.name,
                                  ),
                                  if (gateway != null)
                                    ...Iterable.generate(gateway.field.length)
                                        .map(
                                      (e) {
                                        return FieldWithLabel(
                                          label: gateway.field[e],
                                          hintText: gateway.field[e].capitalize,
                                          isRequired: true,
                                          controller:
                                              wrm.inputFieldControllers[e],
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return gateway
                                                  .field[e].capitalize;
                                            }
                                            return null;
                                          },
                                        )
                                            .animate(
                                                delay: (e * 100 as int)
                                                    .milliseconds)
                                            .slideY()
                                            .fadeIn();
                                      },
                                    )
                                ],
                              );
                            },
                          ),
                        ]),
                  ),
                ),
                2.toHeight,
                Container(
                  decoration: BoxDecoration(
                    color: context.dProvider.whiteColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: ValueListenableBuilder(
                    valueListenable: wrm.isLoading,
                    builder: (context, loading, child) {
                      return CustomButton(
                          onPressed: () {
                            wrm.tryWithdrawRequest(context);
                          },
                          btText: LocalKeys.withdraw,
                          isLoading: loading);
                    },
                  ),
                )
              ],
            );
          }),
        ));
  }
}
