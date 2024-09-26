import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/field_with_label.dart';

import '../../../app_static_values.dart';
import '../../../utils/components/custom_dropdown.dart';
import '../../../utils/components/field_label.dart';
import '../../../view_models/send_offer_view_model/send_offer_view_model.dart';

class SendOfferInfos extends StatelessWidget {
  const SendOfferInfos({super.key});

  @override
  Widget build(BuildContext context) {
    final pom = SendOfferViewModel.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldWithLabel(
          label: LocalKeys.revision,
          hintText: LocalKeys.enterRevisionAmount,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          isRequired: true,
          controller: pom.revisionController,
          validator: (price) {
            final amount = price.toString().tryToParse;
            if (amount <= 0) {
              return LocalKeys.enterRevisionAmount;
            }
            return null;
          },
        ),
        FieldLabel(
          label: LocalKeys.deliveryTime,
          isRequired: true,
        ),
        ValueListenableBuilder(
          valueListenable: pom.selectedDDate,
          builder: (context, dDate, child) {
            return CustomDropdown(
              LocalKeys.selectLengths,
              jobLengths,
              (value) {
                pom.selectedDDate.value = value;
              },
              value: dDate,
            );
          },
        ),
        16.toHeight,
        FieldLabel(
          label: LocalKeys.description,
          isRequired: true,
        ),
        FlutterSummernote(
          hint: pom.descriptionController.text.isEmpty
              ? LocalKeys.enterDescription
              : null,
          hasAttachment: false,
          value: pom.descriptionController.text,
          height: 360,
          showBottomToolbar: false,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: context.dProvider.black7,
              width: 1,
            ),
          ),
          key: pom.keyEditor,
        ),
      ],
    );
  }
}
