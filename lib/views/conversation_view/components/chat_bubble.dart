import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/conversation_service.dart';
import 'package:xilancer/views/chat_list_view/components/chat_tile_avatar.dart';
import 'package:xilancer/views/conversation_view/components/attachment_bubble.dart';
import 'package:xilancer/views/conversation_view/components/offer_bubble.dart';
import 'package:xilancer/views/conversation_view/components/project_bubble.dart';
import 'package:xilancer/views/home_view/components/job_card.dart';

import '../../../helper/svg_assets.dart';
import '../../../models/conversation_model.dart';

class ChatBubble extends StatelessWidget {
  final bool senderFromWeb;
  final int index;
  final Datum datum;
  final clientImage;
  final name;
  const ChatBubble({
    required this.senderFromWeb,
    required this.datum,
    required this.index,
    super.key,
    required this.clientImage,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if ((datum.file != null &&
                (datum.file is File || datum.file.toString().isNotEmpty)) ||
            ((datum.message?.message != null &&
                datum.message!.message!.isNotEmpty)) ||
            ((datum.message?.project != null)))
          Row(
            mainAxisAlignment:
                senderFromWeb ? MainAxisAlignment.start : MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: senderFromWeb
                ? widgetList(
                    context,
                    datum.message?.message ??
                        datum.message?.project?.interviewMessage,
                    clientImage.toString(),
                    name)
                : widgetList(context, datum.message?.message,
                        clientImage.toString(), name)
                    .reversed
                    .toList(),
          ),
      ],
    );
  }

  widgetList(BuildContext context, message, imageUrl, name) {
    final dateListener = ValueNotifier(false);
    final cs = Provider.of<ConversationService>(context, listen: false);
    return [
      ChatTileAvatar(
        name: name,
        size: 32.0,
        imageUrl: imageUrl,
      ),
      12.toWidth,
      Column(
          crossAxisAlignment:
              senderFromWeb ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            if ((message ?? "").isNotEmpty && name.trim().isNotEmpty)
              GestureDetector(
                onTap: () {
                  dateListener.value = !dateListener.value;
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  constraints: BoxConstraints(maxWidth: context.width - 84),
                  decoration: BoxDecoration(
                      color: senderFromWeb
                          ? context.dProvider.whiteColor
                          : context.dProvider.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(12),
                        bottomRight: const Radius.circular(12),
                        topRight: senderFromWeb
                            ? const Radius.circular(12)
                            : const Radius.circular(0),
                        topLeft: senderFromWeb
                            ? const Radius.circular(0)
                            : const Radius.circular(12),
                      )),
                  child: Text(
                    message,
                    textAlign: senderFromWeb ? null : TextAlign.end,
                    style: context.titleMedium?.copyWith(
                        fontSize: 14,
                        color: senderFromWeb
                            ? null
                            : context.dProvider.whiteColor),
                  ),
                ),
              ),
            if (message != null && name.toString().isNotEmpty) 8.toHeight,
            if (datum.message?.project != null)
              ProjectBubble(
                title: datum.message?.project?.title ?? "----",
                imageUrl: datum.message?.project?.type == "job"
                    ? null
                    : "${cs.conversationModel.projectImagePath}/${datum.message?.project?.image}",
                senderFromWeb: senderFromWeb,
                type: datum.message?.project?.type,
                id: datum.message?.project?.id,
              ),
            if (datum.file != null &&
                (datum.file is File || datum.file.toString().isNotEmpty))
              AttachmentBubble(
                file: datum.file,
                senderFromWeb: senderFromWeb,
              ),
            ValueListenableBuilder(
              valueListenable: dateListener,
              builder: (context, value, child) {
                return value == true
                    ? Text(
                        formatDateTime(datum.createdAt ?? DateTime.now()),
                        style: context.bodySmall,
                      )
                    : const SizedBox();
              },
            ),
            if (5 == 1)
              OfferBubble(
                title: "Kathryn has sent you an offer",
                description:
                    "Hello, I am offering you this amount as we agreed in our conversation. Hopefully I’ll get a great product.",
                totalAmount: "380",
                deadline: DateTime.now(),
                milestones: const [],
                senderFromWeb: senderFromWeb,
              ),
          ])
    ];
  }
}
