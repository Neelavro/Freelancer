import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/my_offers_service.dart';
import 'package:xilancer/view_models/my_offers_view_model/my_offers_view_model.dart';
import 'package:xilancer/views/my_offers_view/components/my_offer_card.dart';

import '../../utils/components/custom_future_widget.dart';
import '../../utils/components/custom_preloader.dart';
import '../../utils/components/custom_refresh_indicator.dart';
import '../../utils/components/empty_widget.dart';
import '../my_orders_view/components/my_orders_skeleton.dart';
import 'components/my_offers_skeleton.dart';

class MyOffersView extends StatelessWidget {
  static const routeName = "my_offers_view";
  const MyOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    final mom = MyOffersViewModel.instance;
    final olProvider = Provider.of<MyOffersService>(context, listen: false);
    mom.scrollController.addListener(() {
      mom.tryToLoadMore(context);
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(LocalKeys.myOffers),
        ),
        body: CustomRefreshIndicator(
          onRefresh: () async {
            await olProvider.fetchOrderList();
          },
          child: CustomFutureWidget(
              function: olProvider.shouldAutoFetch
                  ? olProvider.fetchOrderList()
                  : null,
              shimmer: const MyOffersSkeleton(),
              child: Consumer<MyOffersService>(builder: (context, mo, child) {
                return Scrollbar(
                  controller: mom.scrollController,
                  child: mo.offerList?.isEmpty != false
                      ? EmptyWidget(title: LocalKeys.noOrderYet)
                      : ListView.separated(
                          controller: mom.scrollController,
                          padding: const EdgeInsets.all(20),
                          itemBuilder: (context, index) {
                            if (mo.nextPage != null &&
                                mo.offerList!.length == (index)) {
                              return const CustomPreloader();
                            }

                            final offerItem = mo.offerList![index];
                            return MyOfferCard(
                              id: offerItem.id,
                              customerName:
                                  "${offerItem.client?.firstName ?? ""} ${offerItem.client?.firstName ?? ""}",
                              offerStatus: offerItem.status.toString(),
                              budget: offerItem.price ?? 0,
                              deadline: offerItem.deadline,
                              customerImage:
                                  "${mo.myOffersModel.profileImagePath}/${offerItem.client?.image}",
                              createdAt: offerItem.createdAt,
                            );
                          },
                          separatorBuilder: (context, index) => 16.toHeight,
                          itemCount: mo.offerList!.length +
                              (mo.nextPage != null && !mo.nexLoadingFailed
                                  ? 1
                                  : 0)),
                );
              })),
        ));
  }
}
