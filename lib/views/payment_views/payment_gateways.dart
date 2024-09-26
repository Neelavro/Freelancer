import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/payment_gateway_service.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';
import 'package:xilancer/utils/components/field_with_label.dart';
import '../../models/payment_gateway_model.dart';
import '../my_order_details_view/components/job_attachment_select.dart';
import '/helper/extension/context_extension.dart';
import '/helper/extension/string_extension.dart';
import '/helper/svg_assets.dart';
import 'components/auth_net_card_infos.dart';

class PaymentGateways extends StatelessWidget {
  final ValueNotifier<Gateway?> gatewayNotifier;
  final ValueNotifier<File?> attachmentNotifier;
  final TextEditingController cardController;
  final TextEditingController usernameController;
  final TextEditingController secretCodeController;
  final TextEditingController zUsernameController;
  final ValueNotifier<DateTime?> expireDateNotifier;
  const PaymentGateways({
    super.key,
    required this.gatewayNotifier,
    required this.attachmentNotifier,
    required this.cardController,
    required this.usernameController,
    required this.secretCodeController,
    required this.zUsernameController,
    required this.expireDateNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentGatewayService>(builder: (context, pg, child) {
      return FutureBuilder(
          future: pg.shouldAutoFetch ? pg.fetchGateways() : null,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const CustomPreloader();
            }
            return Container(
              // padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              decoration: BoxDecoration(
                color: context.dProvider.whiteColor,
              ),
              child: ValueListenableBuilder(
                valueListenable: gatewayNotifier,
                builder: (context, value, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(),
                      Wrap(
                        children: pg.gatewayList
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    gatewayNotifier.value = e;

                                    debugPrint(e.secrectKey.toString());
                                    debugPrint(e.categoryCode.toString());
                                  },
                                  child: Card(
                                    elevation:
                                        gatewayNotifier.value == e ? 5 : 0,
                                    color: context.dProvider.black9,
                                    surfaceTintColor: Colors.white,
                                    shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: gatewayNotifier.value == e
                                            ? BorderSide(
                                                color: context.dProvider.black8)
                                            : BorderSide.none),
                                    child: SizedBox(
                                      height: 54,
                                      width: context.width / 4.3,
                                      child: ClipRRect(
                                        child: Container(
                                            height: 40,
                                            width: (context.width / 4) - 8,
                                            padding: const EdgeInsets.all(6),
                                            child: e.previewLogo
                                                    .toString()
                                                    .endsWith(".svg")
                                                ? SvgPicture.network(
                                                    e.previewLogo.toString())
                                                : CachedNetworkImage(
                                                    imageUrl: e.previewLogo
                                                        .toString(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgAssets.gallery
                                                            .toSVGSized(18),
                                                      ],
                                                    ),
                                                  )),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      if (gatewayNotifier.value?.name == "manual_payment") ...[
                        12.toHeight,
                        AttachmentSelect(
                            selectedAttachment: attachmentNotifier),
                      ],
                      if (gatewayNotifier.value?.name ==
                          "authorize_dot_net") ...[
                        12.toHeight,
                        AuthCardInfos(
                            cardController: cardController,
                            usernameController: usernameController,
                            secretCodeController: secretCodeController,
                            expireDateNotifier: expireDateNotifier),
                      ],
                      if (gatewayNotifier.value?.name == "zitopay") ...[
                        12.toHeight,
                        FieldWithLabel(
                          label: LocalKeys.username,
                          hintText: LocalKeys.enterUsername,
                          controller: zUsernameController,
                        ),
                      ],
                    ]),
              ),
            );
          });
    });
  }
}
