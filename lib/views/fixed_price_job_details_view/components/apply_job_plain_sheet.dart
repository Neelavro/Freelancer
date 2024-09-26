import 'package:flutter/material.dart';
import 'package:xilancer/app_static_values.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_dropdown.dart';
import 'package:xilancer/utils/components/field_label.dart';
import 'package:xilancer/utils/components/field_with_label.dart';
import 'package:xilancer/utils/components/warning_widget.dart';
import 'package:xilancer/view_models/fix_price_job_details_view_model/fix_price_job_details_view_model.dart';

import 'send_offer_attachment_button.dart';
import 'send_offer_buttons.dart';

class ApplyJobPlainSheet extends StatelessWidget {
  const ApplyJobPlainSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final fixedPriceJob = FixPriceJobDetailsViewModel.instance;
    return WillPopScope(
      onWillPop: () async {
        if (fixedPriceJob.loading.value) {
          LocalKeys.requestLoadingPleaseWait.showToast();
          return false;
        }
        return true;
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          color: context.dProvider.whiteColor,
        ),
        constraints: BoxConstraints(
            maxHeight: context.height / 2 +
                (MediaQuery.of(context).viewInsets.bottom / 2)),
        child: Form(
          key: fixedPriceJob.formKey,
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
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom < 20
                          ? 20
                          : MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabel(label: LocalKeys.proposalAmount),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: fixedPriceJob.amountController,
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
                      FieldLabel(label: LocalKeys.deliveryTime),
                      ValueListenableBuilder(
                        valueListenable: fixedPriceJob.dTime,
                        builder: (context, dTime, child) => CustomDropdown(
                          LocalKeys.selectDeliveryTime,
                          jobLengths,
                          (value) {
                            fixedPriceJob.dTime.value = value;
                          },
                          value: dTime,
                        ),
                      ),
                      16.toHeight,
                      FieldWithLabel(
                        label: LocalKeys.revisions,
                        keyboardType: TextInputType.number,
                        controller: fixedPriceJob.revisionController,
                        hintText: LocalKeys.enterRevisionAmount,
                        validator: (value) {
                          if (num.tryParse(value.toString()) is! num) {
                            return LocalKeys.enterValidAmount;
                          }
                          return null;
                        },
                      ),
                      FieldWithLabel(
                        label: LocalKeys.yourCoverLatter,
                        hintText: LocalKeys.writeYourCoverLater,
                        textInputAction: TextInputAction.newline,
                        controller: fixedPriceJob.cLaterController,
                        validator: (value) {
                          if (value!.tr().length < 100) {
                            return LocalKeys.coverLaterMustBeMoreThen;
                          }
                          return null;
                        },
                      ),
                      WarningWidget(text: LocalKeys.jobApplyPlainFileFormat),
                      8.toHeight,
                      ValueListenableBuilder(
                        valueListenable: fixedPriceJob.aFile,
                        builder: (context, value, child) =>
                            SendOfferAttachmentButton(
                          fileNotifier: fixedPriceJob.aFile,
                        ),
                      ),
                      12.toHeight,
                      const SendOfferButtons(),
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.bottom,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrencyPrefix extends StatelessWidget {
  const CurrencyPrefix({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
