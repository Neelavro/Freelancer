import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/helper/svg_assets.dart';
import 'package:xilancer/services/create_project_service.dart';
import 'package:xilancer/utils/components/alerts.dart';
import 'package:xilancer/utils/components/custom_dropdown.dart';

import '../../../view_models/create_project_view_model/create_project_view_model.dart';
import '../../../models/packages_model.dart';

class PackageExtraField extends StatelessWidget {
  final ExtraField extraField;
  final int index;

  PackageExtraField({
    super.key,
    required this.extraField,
    required this.index,
    required this.cpv,
  });
  final CreateProjectViewModel cpv;

  var typeLabel = {
    FieldType.CHECK: LocalKeys.checkBox,
    FieldType.QUANTITY: LocalKeys.quantity,
  };

  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    nameController.text = extraField.name;
    quantityController.text = cpv.quantityValue(extraField).toString();
    return Container(
      height: 146,
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
          border: Border(
            top: BorderSide(color: context.dProvider.black8, width: 1),
            bottom: BorderSide(color: context.dProvider.black8, width: 1),
          )),
      child: Row(
        children: [
          Container(
            width: context.width / 2.2,
            padding: EdgeInsets.only(
              right: dProvider.textDirectionRight ? 20 : 0,
              left: dProvider.textDirectionRight ? 0 : 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  style: context.titleSmall?.bold6,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) =>
                      value!.isEmpty ? LocalKeys.enterTitle : null,
                  decoration: const InputDecoration(
                      // errorBorder: InputBorder.none,
                      // border: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      // focusedBorder: InputBorder.none,
                      // disabledBorder: InputBorder.none,
                      // focusedErrorBorder: InputBorder.none,
                      ),
                  onChanged: (value) {
                    extraField.name = value;
                  },
                ),
                4.toHeight,
                CustomDropdown(
                  "",
                  typeLabel.values.toList(),
                  (value) {
                    extraField.type = value == LocalKeys.checkBox
                        ? FieldType.CHECK
                        : FieldType.QUANTITY;
                    cpv.resetExtraFieldValues(extraField);
                    cpv.packages.notifyListeners();
                  },
                  value: typeLabel[extraField.type],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: VerticalDivider(
              thickness: 2,
              color: context.dProvider.black8,
            ),
          ),
          Container(
            width: context.width / 2.2,
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              children: [
                extraField.type == FieldType.CHECK
                    ? Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          value: cpv.checkboxValue(extraField),
                          onChanged: (value) {
                            debugPrint(extraField.standardValue.toString());
                            cpv.setCheckBoxValue(extraField,
                                value: cpv.checkboxValue(extraField)
                                    ? "off"
                                    : "on");
                          },
                        ),
                      )
                    : TextFormField(
                        controller: quantityController,
                        decoration: InputDecoration(
                          hintText: LocalKeys.price,
                        ),
                        onFieldSubmitted: (value) {
                          cpv.setQuantityValue(extraField, value: value);
                        },
                      ),
                Expanded(child: 4.toHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        cpv.addField(index: index);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            color:
                                context.dProvider.primary05.withOpacity(.10)),
                        child: Icon(
                          Icons.add_rounded,
                          color: context.dProvider.primaryColor,
                        ),
                      ),
                    ),
                    // if (cpProvider.packages[cpProvider.currentIndex]
                    //         .extraFields.length >
                    //     1)
                    12.toWidth,
                    // if (cpProvider.packages[cpProvider.currentIndex]
                    //         .extraFields.length >
                    //     1)
                    GestureDetector(
                      onTap: () {
                        Alerts().confirmationAlert(
                            context: context,
                            title: LocalKeys.areYouSure,
                            onConfirm: () async {
                              cpv.removeField(
                                index: index,
                                id: extraField.id,
                              );
                              context.popFalse;
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            color: context.dProvider.warningColor
                                .withOpacity(.10)),
                        child: SvgAssets.trash.toSVGSized(24,
                            color: context.dProvider.warningColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
