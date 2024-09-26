import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/job_details_service.dart';

class FixPriceJobDetailsViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController amountController = TextEditingController();
  TextEditingController revisionController = TextEditingController();
  TextEditingController cLaterController = TextEditingController();
  ValueNotifier<String?> dTime = ValueNotifier(null);
  ValueNotifier<File?> aFile = ValueNotifier(null);
  ValueNotifier<bool> loading = ValueNotifier(false);

  FixPriceJobDetailsViewModel._init();
  static FixPriceJobDetailsViewModel? _instance;
  static FixPriceJobDetailsViewModel get instance {
    _instance ??= FixPriceJobDetailsViewModel._init();
    return _instance!;
  }

  FixPriceJobDetailsViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  get dTimeValidate {
    if (dTime.value == null) {
      LocalKeys.selectDeliveryTime.showToast();
      return false;
    }
    return true;
  }

  tryOfferSend(BuildContext context) async {
    final jdProvider = Provider.of<JobDetailsService>(context, listen: false);
    final valid = formKey.currentState?.validate();

    if (valid != true || !dTimeValidate) {
      return;
    }
    if (num.parse(amountController.text) >
        jdProvider.jobDetailsModel.jobDetails!.budget!) {
      LocalKeys.offerCannotBeMoreThenBudget.showToast();
      return;
    }
    loading.value = true;
    jdProvider
        .trySendingOffer(
            (jdProvider.jobDetailsModel.jobDetails?.userId).toString(),
            (jdProvider.jobDetailsModel.jobDetails?.id).toString(),
            amountController.text,
            dTime.value.toString(),
            revisionController.text,
            cLaterController.text,
            aFile.value)
        .then((value) {
      if (value == true) {
        Provider.of<JobDetailsService>(context, listen: false)
            .setAlreadyApplied();
        context.popFalse;
      }
      loading.value = false;
    });
  }
}
