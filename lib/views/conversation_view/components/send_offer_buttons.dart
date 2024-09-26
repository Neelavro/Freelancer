import 'package:flutter/material.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/view_models/send_offer_view_model/send_offer_view_model.dart';

import '../../../helper/local_keys.g.dart';

class SendOfferButtons extends StatelessWidget {
  final clientId;
  const SendOfferButtons({super.key, this.clientId});

  @override
  Widget build(BuildContext context) {
    final som = SendOfferViewModel.instance;
    return ValueListenableBuilder(
      valueListenable: som.isLoading,
      builder: (context, loading, child) {
        return CustomButton(
            onPressed: () {
              som.trySendingOffer(context, clientId: clientId);
            },
            btText: LocalKeys.sendOffer,
            isLoading: loading);
      },
    );
  }
}
