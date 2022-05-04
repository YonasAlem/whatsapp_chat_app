import 'package:flutter/material.dart';
import 'package:whatsapp_chat_app/common/extensions/custom_theme_extension.dart';
import 'package:whatsapp_chat_app/common/utils/coloors.dart';
import 'package:whatsapp_chat_app/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_chat_app/common/widgets/short_h_bar.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({Key? key}) : super(key: key);

  displayModalBottomSheet(context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ShortHBar(),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 20),
                  CustomIconButton(
                    onTap: () => Navigator.of(context).pop(),
                    icon: Icons.close_outlined,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'App language',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(
                color: context.color.greyColor!.withOpacity(0.3),
                thickness: 0.5,
              ),
              RadioListTile(
                value: true,
                groupValue: true,
                activeColor: Coloors.greenDark,
                onChanged: (value) {},
                title: const Text('English'),
                subtitle: Text(
                  '(phone\'s language)',
                  style: TextStyle(color: context.color.greyColor),
                ),
              ),
              RadioListTile(
                value: true,
                groupValue: false,
                activeColor: Coloors.greenDark,
                onChanged: (value) {},
                title: const Text('አማርኛ'),
                subtitle: Text(
                  'Amharic',
                  style: TextStyle(color: context.color.greyColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.color.langBtnBgColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => displayModalBottomSheet(context),
        borderRadius: BorderRadius.circular(20),
        splashFactory: NoSplash.splashFactory,
        highlightColor: context.color.langBtnHighlightColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.language,
                color: Coloors.greenDark,
              ),
              SizedBox(width: 10),
              Text(
                'English',
                style: TextStyle(
                  color: Coloors.greenDark,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.keyboard_arrow_down,
                color: Coloors.greenDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
