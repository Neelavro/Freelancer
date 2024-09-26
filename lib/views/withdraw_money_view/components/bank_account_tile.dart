import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/svg_assets.dart';

class BankAccountTile extends StatelessWidget {
  final title;
  final subtitle;
  final hideDivider;
  const BankAccountTile(
      {super.key, this.title, this.subtitle, this.hideDivider = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: context.dProvider.primary05,
            child: SvgAssets.bank.toSVG,
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: FittedBox(
            child: Row(
              children: [
                SvgAssets.edit
                    .toSVGSized(32, color: context.dProvider.primaryColor),
                12.toWidth,
                Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: context.dProvider.warningColor,
                      )),
                  child: SvgAssets.trash
                      .toSVGSized(20, color: context.dProvider.warningColor),
                ),
              ],
            ),
          ),
        ),
        if (!hideDivider)
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
            height: 36,
          ).hp20,
      ],
    );
  }
}
