import '/customizations.dart';

class AppUrls {
  static String countryUrl = '$baseEndPoint/country/all';
  static String signInUrl = '$baseEndPoint/login';
  static String signUpUrl = '$baseEndPoint/register';
  static String emailVerifyUrl = '$baseEndPoint/email-verify';
  static String cityUrl = '$baseEndPoint/city/all';
  static String stateUrl = '$baseEndPoint/state/all';
  static String profileInfoUrl = '$baseEndPoint/personal/info';
  static String changePasswordUrl = '$baseEndPoint/profile/password/update';
  static String sendOtpUrl = '$baseEndPoint/resend-otp';
  static String resetPasswordUrl = '$baseEndPoint/reset-password';
  static String signOutUrl = '$baseEndPoint/logout';
  static String deleteAccountUrl = '$baseEndPoint/account/delete';
  static String profileInfoUpdate = '$baseEndPoint/personal/info/update';
  static String profileImageUpdate = '$baseEndPoint/profile/image/update';
  static String myOrdersListUrl = '$baseEndPoint/order/all';
  static String orderDetailsUrl = '$baseEndPoint/order/details';
  static String jobListUrl = '$baseEndPoint/job/all';
  static String jobDetailsUrl = '$baseEndPoint/job/details';
  static String sendJobOffer = '$baseEndPoint/job/proposal-send';
  static String profileDetailsUrl = '$baseEndPoint/profile/details';
  static String createTicketUrl = '$baseEndPoint/ticket/create';
  static String ticketListUrl = '$baseEndPoint/ticket/all';
  static String stListUrl = '$baseEndPoint/ticket/single/all-message';
  static String stDepartmentsUrl = '$baseEndPoint/department/all';
  static String fetchTicketChatUrl = '$baseEndPoint/ticket/details';
  static String sendTicketMessageUrl = '$baseEndPoint/ticket/message-send';
  static String notificationsListUrl = '$baseEndPoint/notification/unread';
  static String walletHistoryUrl = '$baseEndPoint/wallet/history';
  static String withdrawHistoryUrl = '$baseEndPoint/withdraw/history';
  static String chatListUrl = '$baseEndPoint/chat/client-list';
  static String conversationUrl = '$baseEndPoint/chat/fetch-record';
  static String messageSendUrl = '$baseEndPoint/chat/message-send?client';
  static String categoryUrl = '$baseEndPoint/category/all';
  static String jobFilter = '$baseEndPoint/job/filter';
  static String chatCredentialUrl = '$baseEndPoint/chat/credentials';
  static String currencyLanguageUrl = '$baseEndPoint/language/all';
  static String translationUrl = '$baseEndPoint/language/string-translate';
  static String nCountUrl = '$baseEndPoint/notification/unread/count';
  static String mCountUrl = '$baseEndPoint/chat/unseen-message/count';
  static String updateNotificationUrl = '$baseEndPoint/notification/read';
  static String myOffersUrl = '$baseEndPoint/job/my-offers';
  static String myProposalsUrl = '$baseEndPoint/job/my-proposals';
  static String fcmTokenUrl = '$baseEndPoint/update/token';
  static String orderAcceptUrl = '$baseEndPoint/order/accept';
  static String orderCancelUrl = '$baseEndPoint/order/decline';
  static String paymentGatewayUrl = '$baseEndPoint/gateway/list';
  static String submitWorkUrl = '$baseEndPoint/order/submit';
  static String createProjectUrl = '$baseEndPoint/project/create';
  static String editProjectUrl = '$baseEndPoint/project/update';
  static String myProjectsUrl = '$baseEndPoint/project/list';
  static String fetchProjectDetailsUrl = '$baseEndPoint/project/details';
  static String withdrawSettingsUrl = '$baseEndPoint/withdraw/settings';
  static String withdrawRequestUrl = '$baseEndPoint/withdraw/request';
  static String walletDepositUrl = '$baseEndPoint/wallet/deposit';
  static String updateDepositPaymentUrl =
      '$baseEndPoint/wallet/deposit/update-payment';
  static String subscriptionTypeListUrl = '$baseEndPoint/subscription/types';
  static String subscriptionListUrl = '$baseEndPoint/subscription/list';
  static String subscriptionHistoryUrl =
      '$baseEndPoint/subscription/history/list';
  static String subsBuyUrl = '$baseEndPoint/subscription/buy';
  static String updateSubsPaymentUrl =
      '$baseEndPoint/subscription/buy/update-payment';
  static String sendCustomOfferUrl = '$baseEndPoint/offer/send';
  static String socialSignInUrl = '$baseEndPoint/social/login';
  static String projectStatusChangeUrl = '$baseEndPoint/project/availability';
  static String projectDeleteUrl = '$baseEndPoint/project/delete';
  static String profileStatusChangeUrl =
      '$baseEndPoint/project/user-work-availability-status';
}
