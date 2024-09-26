import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/utils/components/custom_dropdown.dart';
import 'package:xilancer/utils/components/field_with_label.dart';

import '../../../app_static_values.dart';
import '../../../helper/local_keys.g.dart';
import '../../../utils/components/field_label.dart';
import '../../../view_models/send_offer_view_model/send_offer_view_model.dart';
import '../../conversation_view/components/send_offer_sheet.dart';
import 'milestone_sheet_buttons.dart';

class MilestoneSheet extends StatelessWidget {
  final bool editing;
  final dynamic id;
  const MilestoneSheet({
    super.key,
    this.editing = false,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    final pom = SendOfferViewModel.instance;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: context.dProvider.whiteColor,
      ),
      constraints: BoxConstraints(
          maxHeight: context.height / 2 +
              (MediaQuery.of(context).viewInsets.bottom / 2)),
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
                Form(
                  key: pom.mFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldWithLabel(
                        label: LocalKeys.milestoneName,
                        hintText: LocalKeys.enterName,
                        isRequired: true,
                        controller: pom.mNameController,
                        textInputAction: TextInputAction.next,
                        validator: (name) {
                          return name.toString().length < 5
                              ? LocalKeys.invalidName
                              : null;
                        },
                      ),
                      FieldWithLabel(
                        label: LocalKeys.milestoneAmount,
                        hintText: "123",
                        isRequired: true,
                        textInputAction: TextInputAction.next,
                        controller: pom.mPriceController,
                        keyboardType: TextInputType.number,
                        prefixIcon: const CurrencyPrefix(),
                        validator: (price) {
                          final amount = price.toString().tryToParse;
                          if (amount < 0) {
                            return LocalKeys.enterValidAmount;
                          }
                          return null;
                        },
                      ),
                      FieldWithLabel(
                        label: LocalKeys.revision,
                        hintText: LocalKeys.enterRevisionAmount,
                        isRequired: true,
                        controller: pom.mRevisionController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        validator: (price) {
                          final amount = price.toString().tryToParse;
                          if (amount < 0) {
                            return LocalKeys.enterValidAmount;
                          }
                          return null;
                        },
                      ),
                      FieldLabel(
                        label: LocalKeys.deliveryTime,
                        isRequired: true,
                      ),
                      ValueListenableBuilder(
                        valueListenable: pom.mSelectedDDate,
                        builder: (context, dDate, child) {
                          return CustomDropdown(
                            LocalKeys.selectLengths,
                            jobLengths,
                            (value) {
                              pom.mSelectedDDate.value = value;
                            },
                            value: dDate,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                FieldLabel(
                  label: LocalKeys.description,
                  isRequired: true,
                ),
                FlutterSummernote(
                  hint: pom.milestoneDescriptionController.text.isEmpty
                      ? LocalKeys.writeMilestoneDesc
                      : null,
                  hasAttachment: false,
                  value: pom.milestoneDescriptionController.text,
                  height: 360,
                  showBottomToolbar: false,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.dProvider.black7,
                      width: 1,
                    ),
                  ),
                  key: pom.mKeyEditor,
                ),
                16.toHeight,
                MilestoneSheetButtons(
                  editing: editing,
                  id: id,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
