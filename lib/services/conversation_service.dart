import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../data/network/network_api_services.dart';
import '../helper/pusher_helper.dart';
import '../models/conversation_model.dart';
import 'chat_list_service.dart';

class ConversationService with ChangeNotifier {
  ConversationModel? _conversationModel;
  ConversationModel get conversationModel =>
      _conversationModel ?? ConversationModel();

  var token = "";
  var id = "";

  var nextPage;

  bool nextPageLoading = false;

  bool nexLoadingFailed = false;

  bool shouldAutoFetch(conversationId) =>
      conversationId.toString() != id.toString() || token.isInvalid;

  fetchConversationMessages(conversationId,
      {required BuildContext context, clientId, freelancerId}) async {
    try {
      token = getToken;
      id = conversationId;
      var url = "${AppUrls.conversationUrl}/$conversationId";
      try {
        setConversationId(conversationId);
        Provider.of<ChatListService>(context, listen: false)
            .setChatRead(conversationId);
        PusherHelper().connectToPusher(context, clientId, freelancerId);
      } catch (e) {
        debugPrint(e.toString());
      }
      final responseData = await NetworkApiServices()
          .getApi(url, LocalKeys.message, headers: acceptJsonAuthHeader);

      if (responseData != null) {
        final tempData = ConversationModel.fromJson(responseData);
        _conversationModel = tempData;
        nextPage = tempData.allMessage?.nextPageUrl;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  trySendingMessage(message, File? file, clientId) async {
    final url = AppUrls.messageSendUrl;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields
        .addAll({'client_id': clientId.toString(), 'message': message ?? ""});
    debugPrint({'client_id': clientId.toString(), 'message': message ?? ""}
        .toString());
    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath("file", file.path,
          filename: basename(file.path)));
    }
    request.headers.addAll(acceptJsonAuthHeader);

    final responseData = await NetworkApiServices()
        .postWithFileApi(request, LocalKeys.sendMessage);

    if (responseData != null) {
      try {
        AssetsAudioPlayer.newPlayer()
            .open(
          Audio("assets/audios/message_sent.mp3"),
          autoStart: true,
          showNotification: false,
        )
            .onError((error, stackTrace) {
          debugPrint("error: $error".toString());
        });
      } catch (e) {}
      _conversationModel?.allMessage?.data?.insert(
          0,
          Datum(
            fromUser: "2",
            message: Message(message: message.isEmpty ? null : message),
            file: file,
          ));
      notifyListeners();
      return true;
    }
  }

  void addNewMessage(messageReceived) {
    debugPrint("trying to add new message".toString());
    try {
      AssetsAudioPlayer.newPlayer().open(
        Audio("assets/audios/message_received.mp3"),
        autoStart: true,
        showNotification: false,
      );
    } catch (e) {}
    _conversationModel?.allMessage?.data
        ?.insert(0, Datum.fromJson(messageReceived));
    notifyListeners();
  }

  void fetchNextPage() async {
    token = getToken;
    if (nextPageLoading) return;
    nextPageLoading = true;
    final responseData = await NetworkApiServices()
        .getApi(nextPage, LocalKeys.jobList, headers: commonAuthHeader);

    if (responseData != null) {
      final tempData = ConversationModel.fromJson(responseData);
      tempData.allMessage?.data?.forEach((element) {
        _conversationModel?.allMessage?.data?.add(element);
      });
      nextPage = tempData.allMessage?.nextPageUrl;
    } else {
      nexLoadingFailed = true;
      Future.delayed(const Duration(seconds: 1)).then((value) {
        nexLoadingFailed = false;
        notifyListeners();
      });
    }
    nextPageLoading = false;
    notifyListeners();
  }
}
