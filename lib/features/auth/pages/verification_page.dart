import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_chat_app/common/extensions/custom_theme_extension.dart';
import 'package:whatsapp_chat_app/common/widgets/my_icon_button.dart';
import 'package:whatsapp_chat_app/features/auth/controllers/auth_controller.dart';
import 'package:whatsapp_chat_app/features/auth/widgets/custom_text_field.dart';

class VerificationPage extends ConsumerWidget {
  static const String id = 'verification';
  const VerificationPage({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  final String phoneNumber;
  final String verificationId;

  void verifiySmsCode(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authControllerProvider).verifiySmsCode(
          context: context,
          smsCodeId: verificationId,
          smsCode: smsCode,
          mounted: true,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Verify your number',
          style: TextStyle(color: context.color.authAppbarTextColor),
        ),
        centerTitle: true,
        actions: [
          MyIconButton(
            onTap: () {},
            // icon: Icons.more_vert,
            icon: Icons.more_vert,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(color: context.color.greyColor, height: 1.5),
                  children: [
                    TextSpan(
                      text: "You've tried to register $phoneNumber. wait"
                          "before requesting an SMS or call with your code.  ",
                    ),
                    TextSpan(
                      text: "Wrong number?",
                      style: TextStyle(color: context.color.blueColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: CustomTextField(
                hintText: '- - -  - - -',
                fontSize: 30,
                autoFocus: true,
                keyBoardType: TextInputType.number,
                onChanged: (value) {
                  if (value.length == 6) return verifiySmsCode(context, ref, value);
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Enter 6-digit code',
              style: TextStyle(color: context.color.greyColor),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.message, color: context.color.greyColor),
                const SizedBox(width: 20),
                Text(
                  'Resend SMS',
                  style: TextStyle(color: context.color.greyColor),
                ),
              ],
            ),
            Divider(color: context.color.blueColor!.withOpacity(0.2)),
            Row(
              children: [
                Icon(Icons.phone, color: context.color.greyColor),
                const SizedBox(width: 20),
                Text(
                  'Call Me',
                  style: TextStyle(color: context.color.greyColor),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
