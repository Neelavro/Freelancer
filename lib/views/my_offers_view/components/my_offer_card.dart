import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/views/my_offers_view/components/my_offer_card_infos.dart';

class MyOfferCard extends StatelessWidget {
  final id;
  final customerName;
  final budget;
  final deadline;
  final offerStatus;
  final customerImage;
  final paymentStatus;
  final createdAt;

  const MyOfferCard(
      {super.key,
      this.id,
      this.customerName,
      this.budget,
      this.deadline,
      this.offerStatus,
      this.customerImage,
      this.paymentStatus,
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
          MyOfferCardInfos(
            id: id,
            customerName: customerName,
            budget: budget,
            deadline: deadline,
            offerStatus: offerStatus,
            customerImage: customerImage,
            paymentStatus: paymentStatus,
            createdAt: createdAt,
          ),
        ],
      ),
    );
  }
}
