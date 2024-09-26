import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/create_project_service.dart';
import 'package:xilancer/utils/components/custom_dropdown.dart';

import '../../../view_models/create_project_view_model/create_project_view_model.dart';
import '../../../models/packages_model.dart';

class PackageRevisions extends StatelessWidget {
  final Package package;
  final int index;
  PackageRevisions({
    super.key,
    required this.cpv,
    required this.package,
    required this.index,
  });
  final CreateProjectViewModel cpv;

  TextEditingController revisionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    revisionController.text = package.revision.toString();
    return Container(
      height: 72,
      // padding: const EdgeInsets.symmetric(vertical: 12),
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
            child: Text(LocalKeys.revisions, style: context.titleSmall?.bold6),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: VerticalDivider(
              thickness: 2,
              color: context.dProvider.black8,
            ),
          ),
          Container(
            width: context.width / 2.2,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextFormField(
              controller: revisionController,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) {
                package.revision = value.tryToParse;
                cpv.packages.notifyListeners();
              },
            ),
          ),
        ],
      ),
    );
  }
}
