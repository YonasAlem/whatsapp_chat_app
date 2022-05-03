import 'package:flutter/material.dart';
import 'package:whatsapp_chat_app/common/extensions/custom_theme_extension.dart';
import 'package:whatsapp_chat_app/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_chat_app/features/auth/pages/login_page.dart';
import 'package:whatsapp_chat_app/features/welcome/widgets/language_button.dart';
import 'package:whatsapp_chat_app/features/welcome/widgets/privacy_and_terms.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  navigateToLoginPage(context) {
    Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Image.asset(
                'assets/images/circle.png',
                alignment: Alignment.bottomCenter,
                color: context.theme.circleImageColor,
              ),
            ),
          ),
          const SizedBox(height: 45),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "Welcome to WhatsApp",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const PrivacyAndTerms(),
                CustomElevatedButton(
                  onPressed: () => navigateToLoginPage(context),
                  text: "AGREE AND CONTINUE",
                ),
                const SizedBox(height: 50),
                const LanguageButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
