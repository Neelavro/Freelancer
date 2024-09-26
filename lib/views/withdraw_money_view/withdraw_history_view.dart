import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/withdraw_history_service.dart';
import 'package:xilancer/utils/components/custom_refresh_indicator.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/view_models/withdraw_requests_view_model/withdraw_requests_view_model.dart';
import 'package:xilancer/views/withdraw_money_view/components/withdraw_history_tile.dart';

import '../../utils/components/custom_future_widget.dart';
import '../../utils/components/empty_widget.dart';
import '../../utils/components/scrolling_preloader.dart';
import 'components/withdraw_history_list_skeleton.dart';

class WithdrawHistoryView extends StatelessWidget {
  static const routeName = "withdraw_history_view";
  const WithdrawHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final wvm = WithdrawRequestsViewModel.instance;
    ExpansionTileController controller = ExpansionTileController();
    wvm.scrollController.addListener(() {
      wvm.tryToLoadMore(context);
    });
    final whProvider =
        Provider.of<WithdrawHistoryService>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          leading: const NavigationPopIcon(),
          title: Text(LocalKeys.withdrawHistory),
        ),
        body: CustomRefreshIndicator(
          onRefresh: () async {
            await whProvider.fetchWithdrawHistory();
          },
          child: CustomFutureWidget(
            function: whProvider.shouldAutoFetch
                ? whProvider.fetchWithdrawHistory()
                : null,
            shimmer: const WithdrawHistoryListSkeleton(),
            child:
                Consumer<WithdrawHistoryService>(builder: (context, wh, child) {
              return Scrollbar(
                controller: wvm.scrollController,
                child: wh.withdrawHistory.histories?.history?.isEmpty ?? true
                    ? Expanded(
                        child: EmptyWidget(title: LocalKeys.noHistoryFound))
                    : ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: wvm.scrollController,
                        padding: const EdgeInsets.all(20),
                        itemBuilder: (context, index) {
                          if (wh.nextPage != null &&
                              wh.withdrawHistory.histories!.history!.length ==
                                  index) {
                            return ScrollPreloader(loading: wh.nextPageLoading);
                          }
                          final hItem =
                              wh.withdrawHistory.histories!.history![index];
                          return WithdrawHistoryTile(
                              id: hItem.id,
                              amount: (hItem.amount ?? 0),
                              pMethod: hItem.gatewayFields["bank_name"]
                                      ?.toString() ??
                                  (hItem.gatewayFields.values.toList() as List)
                                      .firstOrNull
                                      ?.toString() ??
                                  "---",
                              controller: controller,
                              pStatus: hItem.status.toString() == "3"
                                  ? LocalKeys.canceled
                                  : (hItem.status.toString() == "2"
                                      ? LocalKeys.complete
                                      : LocalKeys.pending),
                              note: hItem.note,
                              image: hItem.image,
                              path: wh.withdrawHistory.path ?? "",
                              cDate: hItem.createdAt ?? DateTime.now());
                        },
                        separatorBuilder: (context, index) => 12.toHeight,
                        itemCount: (wh.withdrawHistory.histories?.history ?? [])
                                .length +
                            (wh.nextPage != null && !wh.nexLoadingFailed
                                ? 1
                                : 0)),
              );
            }),
          ),
        ));
  }
}
