import 'package:flutter/material.dart';
import 'package:whatsapp_chat_app/features/auth/pages/login_page.dart';
import 'package:whatsapp_chat_app/features/auth/pages/user_info_page.dart';
import 'package:whatsapp_chat_app/features/auth/pages/verification_page.dart';
import 'package:whatsapp_chat_app/features/home/pages/home_page.dart';

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
      return MaterialPageRoute(builder: (context) => const UserInfoPage());
    case HomePage.id:
      return MaterialPageRoute(builder: (context) => const HomePage());
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(body: Center(child: Text('No Page Route Provided'))),
      );
  }
}
