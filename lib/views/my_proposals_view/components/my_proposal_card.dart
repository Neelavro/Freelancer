import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/views/my_offers_view/components/my_offer_card_infos.dart';

import 'my_proposal_card_infos.dart';

class MyProposalCard extends StatelessWidget {
  final id;
  final budget;
  final deadline;
  final isSeen;
  final isRejected;
  final isInterviewed;
  final isShortListed;
  final createdAt;
  final jobTitle;
  final description;
  final attachment;

  const MyProposalCard(
      {super.key,
      this.id,
      this.budget,
      this.deadline,
      this.isSeen,
      this.isRejected,
      this.isInterviewed,
      this.isShortListed,
      this.description,
      this.attachment,
      this.jobTitle,
      this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.dProvider.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyProposalCardInfos(
            id: id,
            isSeen: isSeen,
            budget: budget,
            deadline: deadline,
            isInterviewed: isInterviewed,
            isRejected: isRejected,
            isShortListed: isShortListed,
            createdAt: createdAt,
            description: description,
            jobTitle: jobTitle,
            attachment: attachment,
          ),
        ],
      ),
    );
  }
}
