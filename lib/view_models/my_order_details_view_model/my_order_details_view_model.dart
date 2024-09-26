import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/services/order_details_service.dart';
import 'package:xilancer/utils/components/alerts.dart';

import '../../helper/local_keys.g.dart';

class MyOrderDetailsViewModel {
  ValueNotifier<int> selectedTitleIndex = ValueNotifier(0);
  ValueNotifier<File?> selectedFile = ValueNotifier(null);
  ValueNotifier<bool> fileSubmitLoading = ValueNotifier(false);
  TextEditingController workSubmitDescController = TextEditingController();

  final GlobalKey<FormState> workSubmitFormKey = GlobalKey();

  final GlobalKey<FlutterSummernoteState> keyEditor =
      GlobalKey(debugLabel: DateTime.now().millisecondsSinceEpoch.toString());

  MyOrderDetailsViewModel._init();
  static MyOrderDetailsViewModel? _instance;
  static MyOrderDetailsViewModel get instance {
    _instance ??= MyOrderDetailsViewModel._init();
    return _instance!;
  }

  MyOrderDetailsViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  void tryCancelOrder(BuildContext context, id) {
    final odProvider = Provider.of<OrderDetailsService>(context, listen: false);
    Alerts().confirmationAlert(
        context: context,
        title: LocalKeys.cancelOrderQ,
        description: LocalKeys.areYouSureToCancel,
        buttonText: LocalKeys.cancel,
        onConfirm: () async {
          await odProvider
              .tryCancelOrder(orderId: id, action: "cancel")
              .then((v) {
            if (v == true) {
              LocalKeys.orderSuccessfullyCanceled.showToast();
              context.popTrue;
            }
          });
        });
  }

  void tryDeclineOrder(BuildContext context, id) {
    final odProvider = Provider.of<OrderDetailsService>(context, listen: false);
    Alerts().confirmationAlert(
        context: context,
        title: LocalKeys.declineOrderQ,
        description: LocalKeys.orderDeclineWarning,
        buttonText: LocalKeys.decline,
        onConfirm: () async {
          await odProvider
              .tryCancelOrder(orderId: id, action: "decline")
              .then((v) {
            if (v == true) {
              LocalKeys.orderDeclinedAccepted.showToast();
              context.popTrue;
            }
          });
        });
  }

  void tryAcceptOrder(BuildContext context, id) {
    final odProvider = Provider.of<OrderDetailsService>(context, listen: false);
    Alerts().confirmationAlert(
        context: context,
        title: LocalKeys.acceptOrderQ,
        description: LocalKeys.orderAcceptWarning,
        buttonText: LocalKeys.accept,
        buttonColor: context.dProvider.primaryColor,
        onConfirm: () async {
          await odProvider.tryAcceptOrder(orderId: id).then((v) {
            if (v == true) {
              LocalKeys.orderSuccessfullyAccepted.showToast();
            }
          });
          context.popTrue;
        });
  }

  trySubmittingWork(BuildContext context, {milestoneId}) async {
    if (selectedFile.value == null) {
      LocalKeys.selectFile.showToast();
      return;
    }

    String? etEditor = await keyEditor.currentState?.getText();
    etEditor = await keyEditor.currentState?.getText();
    debugPrint((etEditor).toString());
    if (etEditor == null) {
      LocalKeys.enterSomeDescription.showToast();
      return;
    }
    workSubmitDescController.text = etEditor;
    if (workSubmitDescController.text.length < 5) {
      LocalKeys.enterSomeDescription.showToast();
      return;
    }
    fileSubmitLoading.value = true;
    await Provider.of<OrderDetailsService>(context, listen: false)
        .trySubmitOrder(milestoneId,
            file: selectedFile.value,
            description: workSubmitDescController.text)
        .then((v) {
      if (v == true) {
        context.popFalse;
      }
    });
    fileSubmitLoading.value = false;
  }
}
