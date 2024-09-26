import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/services/subscription_buy_service.dart';

import '../../helper/local_keys.g.dart';
import '../../models/payment_gateway_model.dart';
import '../../services/profile_info_service.dart';
import '../../views/onboarding_view/onboarding_view.dart';
import '../../views/payment_views/payment_methode_navigator_helper.dart';
import '../../views/proccess_status_view/proccess_status_view.dart';
import '../onboarding_view_model/onboarding_view_model.dart';

class SubscriptionBuyViewModel {
  ValueNotifier<bool> walletSelect = ValueNotifier(false);
  ValueNotifier<bool> tacPP = ValueNotifier(false);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<Gateway?> selectedGateway = ValueNotifier(null);
  ValueNotifier<File?> selectedAttachment = ValueNotifier(null);
  TextEditingController milestoneDescriptionController =
      TextEditingController();
  TextEditingController revisionController = TextEditingController();
  TextEditingController aCardController = TextEditingController();
  TextEditingController zUsernameController = TextEditingController();
  TextEditingController authCodeController = TextEditingController();

  ValueNotifier<DateTime?> authNetExpireDate = ValueNotifier(null);

  dynamic _id;

  get id => _id;

  SubscriptionBuyViewModel._init();
  static SubscriptionBuyViewModel? _instance;
  static SubscriptionBuyViewModel get instance {
    _instance ??= SubscriptionBuyViewModel._init();
    return _instance!;
  }

  SubscriptionBuyViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  void setSubId(id) {
    _id = id;
  }

  trySubscriptionBuy(BuildContext context) async {
    final sbProvider =
        Provider.of<SubscriptionBuyService>(context, listen: false);

    if (selectedGateway.value == null && !walletSelect.value) {
      LocalKeys.selectAPaymentMethod.showToast();
      return;
    }
    if (!paymentValidate) {
      return;
    }
    isLoading.value = true;
    final requestResult = await sbProvider.trySubscriptionBuy();
    if (requestResult != true) {
      isLoading.value = false;
      return;
    }

    final sb = Provider.of<SubscriptionBuyService>(context, listen: false);
    final pi = Provider.of<ProfileInfoService>(context, listen: false);

    final userEmail = pi.profileInfoModel.data?.email;
    final userPhone = pi.profileInfoModel.data?.phone;
    final userName = pi.profileInfoModel.data?.firstName;
    final userCity = pi.profileInfoModel.data?.city;
    final userAddress = pi.profileInfoModel.data?.city;
    final id = sb.id;
    if (selectedGateway.value?.name == "manual_payment" || walletSelect.value) {
      isLoading.value = false;
      context.toPage(ProcessStatusView(
          title: LocalKeys.requestSentSuccessfully,
          updateStatus: false,
          description: id != null ? "${LocalKeys.orderId}: #$id" : null,
          ebText: LocalKeys.backToHome,
          ebOnTap: (BuildContext context) {
            OnboardingViewModel.dispose;
            context.toUntilPage(const OnboardingView());
          },
          onWillPop: (BuildContext context) {
            OnboardingViewModel.dispose;
            context.toUntilPage(const OnboardingView());
          },
          status: 1));
      return;
    }
    await startPayment(
      context,
      authNetCard: aCardController.text,
      authcCode: aCardController.text,
      zUsername: zUsernameController.text,
      authNetED: authNetExpireDate.value,
      onSuccess: () {
        context.toPage(ProcessStatusView(
            title: LocalKeys.paymentSuccessful,
            updateStatus: true,
            ebText: LocalKeys.backToHome,
            ebOnTap: (BuildContext context) {
              OnboardingViewModel.dispose;
              context.toUntilPage(const OnboardingView());
            },
            onWillPop: (BuildContext context) {
              OnboardingViewModel.dispose;
              context.toUntilPage(const OnboardingView());
            },
            updateFunction: sb.updateDepositPayment,
            status: 1));
      },
      onFailed: () {
        context.toPage(ProcessStatusView(
            title: LocalKeys.paymentFailed,
            updateStatus: false,
            ebText: LocalKeys.backToHome,
            ebOnTap: (BuildContext context) {
              OnboardingViewModel.dispose;
              context.toUntilPage(const OnboardingView());
            },
            onWillPop: (BuildContext context) {
              OnboardingViewModel.dispose;
              context.toUntilPage(const OnboardingView());
            },
            status: 0));
      },
      orderId: sb.id,
      amount: sb.price,
      selectedGateway: selectedGateway.value!,
      userEmail: userEmail,
      userName: userName,
      userPhone: userPhone,
      userCity: userCity,
      userAddress: userAddress,
    );
    isLoading.value = false;
  }

  bool get paymentValidate {
    bool valid = true;
    switch (selectedGateway.value?.name) {
      case "authorize_dot_net":
        if (authCodeController.text.length < 3 ||
            aCardController.text.length < 16 ||
            authNetExpireDate.value == null) {
          LocalKeys.pleaseProvideYourCardInformation.showToast();
          return false;
        }
        break;
      case "manual_payment":
        if (selectedAttachment.value == null) {
          LocalKeys.selectFile.showToast();
          return false;
        }
        break;
      case "zitopay":
        if (zUsernameController.text.isEmpty) {
          LocalKeys.enterUsername.showToast();
          return false;
        }
        break;
      default:
    }
    return valid;
  }
}
