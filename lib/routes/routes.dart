import 'package:flutter/material.dart';
import 'package:whatsapp_chat_app/features/auth/pages/login_page.dart';
import 'package:whatsapp_chat_app/features/auth/pages/user_info_page.dart';
import 'package:whatsapp_chat_app/features/auth/pages/verification_page.dart';
import 'package:whatsapp_chat_app/features/chat/pages/chat_page.dart';
import 'package:whatsapp_chat_app/features/contact/pages/contacts_page.dart';
import 'package:whatsapp_chat_app/features/home/pages/home_page.dart';
import 'package:whatsapp_chat_app/models/user_model.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginPage.id:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case VerificationPage.id:
      final Map args = settings.arguments as Map;
      return MaterialPageRoute(
        builder: (context) => VerificationPage(
          phoneNumber: args['phone'],
          verificationId: args['verificationId'],
        ),
      );
    case UserInfoPage.id:
      String? profileImageUrl = settings.arguments as String?;
      return MaterialPageRoute(
        builder: (context) => UserInfoPage(
          profileImageUrl: profileImageUrl,
        ),
      );
    case HomePage.id:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case ContactsPage.id:
      return MaterialPageRoute(builder: (context) => const ContactsPage());

    case ChatPage.id:
      UserModel user = settings.arguments as UserModel;
      return MaterialPageRoute(
        builder: (context) => ChatPage(
          user: user,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) =>
            const Scaffold(body: Center(child: Text('No Page Route Provided'))),
      );
  }
}
