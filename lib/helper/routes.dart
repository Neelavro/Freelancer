import 'package:xilancer/views/delete_account_view/delete_account_view.dart';
import 'package:xilancer/views/fixed_price_job_details_view/fixed_price_job_details_view.dart';
import 'package:xilancer/views/intro_view/intro_view.dart';
import 'package:xilancer/views/my_offers_view/my_offers_view.dart';
import 'package:xilancer/views/my_order_details_view/my_order_details_view.dart';
import 'package:xilancer/views/my_orders_view/my_orders_view.dart';
import 'package:xilancer/views/my_projects/my_projects_view.dart';
import 'package:xilancer/views/profile_details_view/profile_details_view.dart';
import 'package:xilancer/views/profile_settings_view/profile_settings_view.dart';
import 'package:xilancer/views/support_ticket_list_view/support_ticket_list_view.dart';
import 'package:xilancer/views/wallet_view/wallet_view.dart';

import '../views/create_project_view/create_project_view.dart';
import '../views/my_proposals_view/my_proposals_view.dart';
import '../views/onboarding_view/onboarding_view.dart';
import '../views/project_details_view/project_details_view.dart';
import '../views/subscription_store_view/subscription_store_view.dart';
import '../views/subscription_view/subscription_view.dart';
import '../views/support_ticket_create_view/support_ticket_create_view.dart';
import '../views/withdraw_money_view/withdraw_history_view.dart';
import '../views/withdraw_money_view/withdraw_money_view.dart';
import '/views/change_password_view/change_password_view.dart';
import '/views/conversation_view/conversation_view.dart';
import '/views/profile_edit_view/identity_info_edit_view.dart';
import '/views/profile_edit_view/profile_edit_view.dart';
import '/views/sign_in_view/sign_in_view.dart';
import '/views/sign_up_view/sign_up_view.dart';

class Routes {
  static var routes = {
    SignInView.routeName: (context) => const SignInView(),
    SignUpView.routeName: (context) => const SignUpView(),
    OnboardingView.routeName: (context) => const OnboardingView(),
    ConversationView.routeName: (context) => const ConversationView(),
    ChangePasswordView.routeName: (context) => const ChangePasswordView(),
    IntroView.routeName: (context) => const IntroView(),
    ProfileEditView.routeName: (context) => const ProfileEditView(),
    IdentityInfoEditView.routeName: (context) => const IdentityInfoEditView(),
    MyOrdersView.routeName: (context) => const MyOrdersView(),
    MyOrderDetailsView.routeName: (context) => const MyOrderDetailsView(),
    ProfileSettingsView.routeName: (context) => const ProfileSettingsView(),
    ProfileDetailsView.routeName: (context) => const ProfileDetailsView(),
    DeleteAccountView.routeName: (context) => const DeleteAccountView(),
    WalletView.routeName: (context) => const WalletView(),
    SupportTicketListView.routeName: (context) => const SupportTicketListView(),
    WithdrawHistoryView.routeName: (context) => const WithdrawHistoryView(),
    SupportTicketCreateView.routeName: (context) =>
        const SupportTicketCreateView(),
    FixedPriceJobDetailsView.routeName: (context) =>
        const FixedPriceJobDetailsView(),
    MyOffersView.routeName: (context) => const MyOffersView(),
    MyProposalsView.routeName: (context) => const MyProposalsView(),
    CreateProjectView.routeName: (context) => const CreateProjectView(),
    SubscriptionView.routeName: (context) => const SubscriptionView(),
    SubscriptionStoreView.routeName: (context) => const SubscriptionStoreView(),
    MyProjects.routeName: (context) => const MyProjects(),
    ProjectDetailsView.routeName: (context) => const ProjectDetailsView(),
    WithdrawMoneyView.routeName: (context) => const WithdrawMoneyView(),
  };
}
