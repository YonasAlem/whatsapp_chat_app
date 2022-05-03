import 'package:flutter/material.dart';
import 'package:whatsapp_chat_app/features/auth/pages/login_page.dart';
import 'package:whatsapp_chat_app/features/auth/pages/user_info_page.dart';
import 'package:whatsapp_chat_app/features/auth/pages/verification_page.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginPage.id:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case VerificationPage.id:
      final String phone = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => VerificationPage(phoneNumber: phone));
    case UserInfoPage.id:
      return MaterialPageRoute(builder: (context) => const UserInfoPage());
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(body: Center(child: Text('No Page Route Provided'))),
      );
  }
}
