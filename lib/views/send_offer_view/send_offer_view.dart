import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/field_with_label.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/utils/components/warning_widget.dart';
import 'package:xilancer/view_models/send_offer_view_model/send_offer_view_model.dart';
import 'package:xilancer/views/send_offer_view/components/single_offer_infos.dart';

import '../conversation_view/components/send_offer_buttons.dart';
import '../conversation_view/components/send_offer_sheet.dart';
import 'components/milestones.dart';

class SendOfferView extends StatelessWidget {
  final clientId;
  const SendOfferView({
    super.key,
    this.clientId,
  });

  @override
  Widget build(BuildContext context) {
    final som = SendOfferViewModel.instance;
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationPopIcon(),
        title: Text(LocalKeys.sendOffer),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: context.dProvider.whiteColor,
          ),
          child: Form(
            key: som.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WarningWidget(
                  text: LocalKeys.discusBeforeSendingOffer,
                ),
                16.toHeight,
                FieldWithLabel(
                  label: LocalKeys.totalProposingAmount,
                  hintText: LocalKeys.enterAmount,
                  controller: som.priceController,
                  prefixIcon: const CurrencyPrefix(),
                  keyboardType: TextInputType.number,
                  validator: (price) {
                    final amount = price.toString().tryToParse;
                    if (amount <= 0) {
                      return LocalKeys.enterValidAmount;
                    }
                    return null;
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: som.milestone,
                  builder: (context, m, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          value: m,
                          onChanged: (value) {
                            som.milestone.value = !m;
                          },
                          title: Text(LocalKeys.userMilestone),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        if (!m) const SendOfferInfos(),
                        if (m) const Milestones(),
                      ],
                    );
                  },
                ),
                12.toHeight,
                SendOfferButtons(
                  clientId: clientId,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
