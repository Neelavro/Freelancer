import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/job_details_service.dart';
import 'package:xilancer/views/fixed_price_job_details_view/components/job_details_proposal_card.dart';

class JobDetailsProposals extends StatelessWidget {
  const JobDetailsProposals({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobDetailsService>(builder: (context, jd, child) {
      if (jd.jobDetailsModel.jobDetails?.jobProposals?.isEmpty ??
          true == true) {
        return const SizedBox();
      }
      final jp = jd.jobDetailsModel.jobDetails?.jobProposals ?? [];
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalKeys.proposals,
              style: context.titleMedium?.bold6,
            ).hp20,
            20.toHeight,
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 16,
            ),
            ...jp.sublist(0, jp.length < 10 ? jp.length : 10).map((e) => Column(
                  children: [
                    JobDetailsProposalCard(
                      title: e.freelancerId.toString(),
                      occupation: e.freelancerId.toString(),
                      rating: e.freelancerId.toString(),
                      jobCompleteCount: e.freelancerId.toString(),
                      submitDate: e.createdAt ?? DateTime.now(),
                      location: e.freelancerId.toString(),
                      offeredPrice: (e.amount ?? 0).toStringAsFixed(0),
                      estDuration: e.duration,
                    ),
                    if (jp.last.id.toString() != e.id.toString())
                      Divider(
                        color: context.dProvider.black8,
                        thickness: 2,
                        height: 16,
                      )
                  ],
                )),
          ],
        ),
      );
    });
  }
}
