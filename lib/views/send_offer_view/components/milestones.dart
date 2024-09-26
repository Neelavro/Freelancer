import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/int_extension.dart';

import '../../../helper/local_keys.g.dart';
import '../../../view_models/send_offer_view_model/send_offer_view_model.dart';
import 'milestone_card.dart';
import 'milestone_sheet.dart';

class Milestones extends StatelessWidget {
  const Milestones({super.key});

  @override
  Widget build(BuildContext context) {
    final pom = SendOfferViewModel.instance;
    return ValueListenableBuilder(
      valueListenable: pom.milestones,
      builder: (context, milestones, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...milestones.map((e) => MilestoneCard(milestone: e)).toList(),
            OutlinedButton.icon(
                onPressed: () {
                  pom.resetMilestoneSheet();
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isDismissible: false,
                    isScrollControlled: true,
                    builder: (context) => const MilestoneSheet(),
                  );
                },
                icon: const Icon(Icons.add_rounded),
                label: Text(LocalKeys.addMilestone)),
            16.toHeight,
          ],
        );
      },
    );
  }
}
