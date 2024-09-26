import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/view_models/my_order_details_view_model/my_order_details_view_model.dart';

import '../../work_submit_view/work_submit_view.dart';

class OrderDetailsMilestoneCard extends StatelessWidget {
  final title;
  final milestoneStatus;
  final price;
  final paymentStatus;
  final approvedDate;
  final dueDate;
  final description;
  final totalRevision;
  final remainingRevision;
  final bool allowWorkSend;
  final id;

  const OrderDetailsMilestoneCard({
    super.key,
    required this.id,
    this.title,
    this.milestoneStatus,
    this.price,
    this.paymentStatus,
    this.approvedDate,
    this.dueDate,
    this.description,
    this.totalRevision,
    this.remainingRevision,
    required this.allowWorkSend,
  });

  @override
  Widget build(BuildContext context) {
    final odm = MyOrderDetailsViewModel.instance;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.dProvider.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      title,
                      style: context.titleMedium?.bold6,
                    ),
                  ),
                ],
              ),
              8.toHeight,
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  if (paymentStatus != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: context.dProvider.greenColor.withOpacity(.05)),
                      child: Text(
                        paymentStatus,
                        style: context.titleSmall
                            ?.copyWith(color: context.dProvider.primaryColor),
                      ),
                    ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: milestoneStatus.toString() == "2"
                              ? context.dProvider.greenColor
                              : context.dProvider.primaryColor,
                        )),
                    child: Text(
                      milestoneStatus.toString().getMStatus.capitalize,
                      style: context.titleSmall?.copyWith(
                          color: milestoneStatus.toString() == "2"
                              ? context.dProvider.greenColor
                              : milestoneStatus.toString() == "3"
                                  ? context.dProvider.warningColor
                                  : context.dProvider.primaryColor),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: context.dProvider.yellowColor,
                        )),
                    child: Text(
                      "${LocalKeys.revision}: $totalRevision",
                      style: context.titleSmall
                          ?.copyWith(color: context.dProvider.yellowColor),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: context.dProvider.black6,
                        )),
                    child: Text(
                      "${LocalKeys.revisionLeft}: $remainingRevision",
                      style: context.titleSmall
                          ?.copyWith(color: context.dProvider.black6),
                    ),
                  ),
                ],
              ),
            ],
          ),
          8.toHeight,
          Wrap(
            spacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                "$price".cur,
                style: context.titleMedium?.bold6.copyWith(
                  color: milestoneStatus.toString() == "2"
                      ? context.dProvider.greenColor
                      : context.dProvider.primaryColor,
                ),
              ),
              Text(
                approvedDate is String || dueDate is String
                    ? "${LocalKeys.deliveryTime}: ${approvedDate ?? dueDate}"
                    : "${milestoneStatus == "2" ? LocalKeys.approvedOn : LocalKeys.due} ${DateFormat("dd MMM").format(approvedDate ?? dueDate)}",
                style: context.titleSmall
                    ?.copyWith(color: context.dProvider.black5),
              ),
            ],
          ),
          if (description != null) 8.toHeight,
          if (description != null)
            Text(
              description,
              style:
                  context.titleSmall?.copyWith(color: context.dProvider.black5),
            ),
          if (allowWorkSend) ...[
            8.toHeight,
            ElevatedButton(
                onPressed: () {
                  context.toPage(WorkSubmitView(milestoneId: id));
                },
                child: Text(LocalKeys.submitWork)),
          ]
        ],
      ),
    );
  }
}
