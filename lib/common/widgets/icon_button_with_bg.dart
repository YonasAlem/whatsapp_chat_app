import 'package:flutter/material.dart';
import 'package:whatsapp_chat_app/common/extensions/custom_theme_extension.dart';

class IconButtonWithBg extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData iconData;
  final Color? iconColor;
  final bool hasBorder;
  final Color? borderColor;
  final Color? bgColor;
  const IconButtonWithBg({
    Key? key,
    this.onTap,
    required this.iconData,
    this.hasBorder = false,
    this.borderColor,
    this.bgColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      splashFactory: NoSplash.splashFactory,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(50),
          border: hasBorder
              ? Border.all(
                  color: borderColor ?? context.color.greyColor!.withOpacity(0.2),
                  width: 1,
                  style: BorderStyle.solid,
                )
              : null,
        ),
        child: Center(
          child: Icon(
            iconData,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
