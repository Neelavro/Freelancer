import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';

import '../../../view_models/withdraw_requests_view_model/withdraw_requests_view_model.dart';
import 'expansion_children.dart';
import 'expansion_title.dart';

class WithdrawRequestTile extends StatelessWidget {
  final id;
  final int index;
  final bool paymentFailed;
  final num priceAmount;
  final String paymentStatus;
  final String paymentGateway;
  final Function()? onTap;
  final note;
  final image;
  final String? path;
  const WithdrawRequestTile({
    super.key,
    required this.id,
    required this.index,
    this.paymentFailed = false,
    required this.paymentGateway,
    required this.priceAmount,
    required this.paymentStatus,
    this.onTap,
    this.note,
    this.image,
    this.path,
  });

  @override
  Widget build(BuildContext context) {
    final wrv = WithdrawRequestsViewModel.instance;
    ExpansionTileController controller = ExpansionTileController();
    return SizedBox(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            children: [
              ExpansionTile(
                backgroundColor: context.dProvider.whiteColor,
                tilePadding: const EdgeInsets.all(12),
                childrenPadding:
                    paymentFailed ? null : const EdgeInsets.all(12),
                trailing: const Column(
                  children: [
                    Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
                controller: controller,
                onExpansionChanged: (value) {
                  wrv.toggleInfoView(index, controller);
                },
                collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: context.dProvider.black8)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: context.dProvider.black8)),
                title: ExpansionTitle(
                    priceAmount: priceAmount,
                    paymentGateway: paymentGateway,
                    paymentStatus: paymentStatus,
                    id: id,
                    controller: controller,
                    paymentFailed: paymentFailed),
                children: !((image != null && image != '') || note != null)
                    ? []
                    : [
                        ExpansionChildren(note, image, path),
                      ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
