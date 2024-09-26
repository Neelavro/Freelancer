import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/view_models/fix_price_job_details_view_model/fix_price_job_details_view_model.dart';

import '../../../helper/local_keys.g.dart';

class SendOfferButtons extends StatelessWidget {
  const SendOfferButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final fPriceM = FixPriceJobDetailsViewModel.instance;
    return Row(
      children: [
        Expanded(
          flex: 16,
          child: OutlinedButton(
            onPressed: () {
              context.popFalse;
            },
            child: Text(LocalKeys.cancel),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 16,
          child: ValueListenableBuilder(
            valueListenable: fPriceM.loading,
            builder: (context, loading, child) => CustomButton(
              onPressed: () async {
                fPriceM.tryOfferSend(context);
              },
              btText: LocalKeys.sendOffer,
              isLoading: loading,
            ),
          ),
        ),
      ],
    );
  }
}
