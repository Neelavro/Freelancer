import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/services/order_details_service.dart';
import 'package:xilancer/views/my_order_details_view/components/order_details_work_submit_card.dart';

import '../../../helper/local_keys.g.dart';
import '../../work_submit_view/work_submit_view.dart';

class OrderDetailsWorkSubmit extends StatelessWidget {
  final orderHaveMilestone;
  const OrderDetailsWorkSubmit({super.key, this.orderHaveMilestone = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderDetailsService>(builder: (context, od, child) {
      final orderDetails = od.orderDetailsModel.orderDetails!;
      final wsh = orderDetails.orderSubmitHistory!;
      final mileStones = orderDetails.orderMileStones!;
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocalKeys.workSubmitted,
                  style: context.titleMedium?.bold6,
                ).hp20,
                if (wsh.lastOrNull?.status.toString() != "0" &&
                    orderDetails.status.toString() == "1")
                  ElevatedButton(
                          onPressed: () {
                            var milestoneId;
                            try {
                              milestoneId = mileStones
                                  .firstWhere((element) =>
                                      element.status.toString() == "1")
                                  .id;
                            } catch (e) {}
                            debugPrint(milestoneId.toString());
                            context.toPage(
                                WorkSubmitView(milestoneId: milestoneId));
                          },
                          child: Text(LocalKeys.submitWork))
                      .hp20,
              ],
            ),
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 36,
            ),
            if (wsh.isEmpty)
              Text(
                LocalKeys.noWorkSubmitted,
                style: context.titleSmall
                    ?.copyWith(color: context.dProvider.black5),
              ).hp20,
            ...wsh
                .map((e) => OrderDetailsWorkSubmitCard(
                      submitDate: e.createdAt,
                      status: e.status,
                      attachmentUrl:
                          "${od.orderDetailsModel.attachmentPath}/${e.attachment}",
                      description: e.description,
                    ))
                .toList(),
            if (!orderHaveMilestone)
              Divider(
                color: context.dProvider.black8,
                thickness: 2,
                height: 36,
              ),
            if (!orderHaveMilestone)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                        onPressed: () {}, child: Text(LocalKeys.submitWork))
                    .hp20,
              )
          ],
        ),
      );
    });
  }
}
