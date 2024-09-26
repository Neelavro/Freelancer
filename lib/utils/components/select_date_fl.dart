import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/helper/svg_assets.dart';
import 'package:xilancer/utils/components/field_label.dart';

class SelectDateFL extends StatelessWidget {
  final title;
  final icon;
  final value;
  final onChanged;
  final firstDate;
  final lastDate;
  const SelectDateFL({
    super.key,
    this.title,
    this.icon,
    this.value,
    this.onChanged,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) FieldLabel(label: title),
        OutlinedButton.icon(
            onPressed: () {
              final now = DateTime.now();
              showDatePicker(
                      context: context,
                      initialDate: value ?? now,
                      firstDate: firstDate ??
                          now.subtract(const Duration(days: 40000)),
                      lastDate:
                          lastDate ?? now.add(const Duration(days: 40000)))
                  .then((value) {
                if (value != null && this.value != value) {
                  onChanged(value);
                }
              });
            },
            icon: icon ?? SvgAssets.calender.toSVG,
            label: Text(value == null
                ? LocalKeys.selectDate
                : DateFormat("dd-mm-yyyy").format(value!))),
      ],
    );
  }
}
