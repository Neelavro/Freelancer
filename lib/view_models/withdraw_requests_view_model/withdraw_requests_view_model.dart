import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/models/withdraw_settings_model.dart';
import 'package:xilancer/services/withdraw_history_service.dart';
import 'package:xilancer/services/withdraw_request_service.dart';

class WithdrawRequestsViewModel {
  final ScrollController scrollController = ScrollController();
  final ValueNotifier<String?> nextPage = ValueNotifier('_value');
  final ValueNotifier<int?> selectedIndex = ValueNotifier(null);
  final ValueNotifier<bool> nextPageLoading = ValueNotifier(false);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  ExpansionTileController? expansionTileController;

  ValueNotifier<WithdrawGateway?> selectedGateway = ValueNotifier(null);

  List<TextEditingController> inputFieldControllers = [];
  TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  setSelectedGateway(BuildContext context, value) {
    final gateway = Provider.of<WithdrawRequestService>(context, listen: false)
        .withdrawSettingsModel
        .withdrawGateways
        .firstWhere((element) => element.name == value);
    selectedGateway.value = gateway;
    inputFieldControllers.clear();
    for (var g in gateway.field) {
      inputFieldControllers.add(TextEditingController());
    }
  }

  WithdrawRequestsViewModel._init();
  static WithdrawRequestsViewModel? _instance;
  static WithdrawRequestsViewModel get instance {
    _instance ??= WithdrawRequestsViewModel._init();
    return _instance!;
  }

  static bool get dispose {
    _instance = null;
    return true;
  }

  toggleInfoView(index, ExpansionTileController controller) {
    if (selectedIndex.value == index) {
      selectedIndex.value = null;
      expansionTileController = null;
      return;
    }
    try {
      if (expansionTileController != null &&
          (expansionTileController?.isExpanded ?? false == true)) {
        expansionTileController?.collapse();
      }
    } catch (e) {
      expansionTileController = null;
    }
    expansionTileController = controller;
    selectedIndex.value = index;
  }

  tryToLoadMore(BuildContext context) {
    try {
      final whs = Provider.of<WithdrawHistoryService>(context, listen: false);
      final nextPage = whs.nextPage;
      final nextPageLoading = whs.nextPageLoading;

      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (nextPage != null && !nextPageLoading) {
          whs.fetchNextPage();
          return;
        }
      }
    } catch (e) {}
  }

  void tryWithdrawRequest(BuildContext context) async {
    if (selectedGateway.value == null) {
      LocalKeys.selectAPaymentMethod.showToast();
      return;
    }

    final valid = formKey.currentState?.validate();
    if (valid != true) {
      return;
    }
    isLoading.value = true;
    await Provider.of<WithdrawRequestService>(context, listen: false)
        .tryWithdrawRequest()
        .then((v) {
      if (v == true) {
        LocalKeys.requestSentSuccessfully.showToast();
        context.popFalse;
      }
    });
    isLoading.value = false;
  }
}
