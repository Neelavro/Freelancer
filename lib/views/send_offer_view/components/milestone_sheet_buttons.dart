import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../../../view_models/send_offer_view_model/send_offer_view_model.dart';

class MilestoneSheetButtons extends StatelessWidget {
  final bool editing;
  final dynamic id;
  const MilestoneSheetButtons({
    super.key,
    this.editing = false,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    final pom = SendOfferViewModel.instance;
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: OutlinedButton(
              onPressed: () {
                context.popFalse;
              },
              child: Text(LocalKeys.cancel)),
        ),
        16.toWidth,
        Expanded(
          flex: 1,
          child: ElevatedButton(
              onPressed: () {
                if (editing) {
                  pom.editMilestone(context, id);
                  return;
                }
                pom.addMilestone(context);
              },
              child: Text(
                editing ? LocalKeys.save : LocalKeys.add,
              )),
        ),
      ],
    );
  }
}
