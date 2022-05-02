import 'package:flutter/material.dart';
import 'package:whatsapp_chat_app/common/extensions/custom_theme_extension.dart';
import 'package:whatsapp_chat_app/common/utils/coloors.dart';
import 'package:whatsapp_chat_app/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_chat_app/features/auth/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController countryNameController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void didChangeDependencies() {
    countryCodeController.text = '251';
    countryNameController.text = 'Ethiopia';
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Enter your phone number',
          style: TextStyle(color: context.theme.authAppbarTextColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            splashColor: Colors.transparent,
            splashRadius: 22,
            iconSize: 22,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40),
            icon: Icon(
              Icons.more_vert,
              color: context.theme.greyColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: context.theme.greyColor,
                    height: 1.3,
                  ),
                  children: [
                    const TextSpan(
                      text: 'WhatsApp will need to verify your phone number. ',
                    ),
                    TextSpan(
                      text: "What's my number?",
                      style: TextStyle(color: context.theme.blueColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomTextField(
                onTap: () {},
                controller: countryNameController,
                readOnly: true,
                suffixIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Coloors.greenDark,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: CustomTextField(
                      onTap: () {},
                      controller: countryCodeController,
                      prefixText: ' +',
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      controller: phoneNumberController,
                      hintText: 'phone number',
                      textAlign: TextAlign.left,
                      keyBoardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Carrier charges may apply',
              style: TextStyle(color: context.theme.greyColor),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: CustomElevatedButton(
          onPressed: () {},
          text: 'NEXT',
          buttonWidth: 90,
        ),
      ),
    );
  }
}
