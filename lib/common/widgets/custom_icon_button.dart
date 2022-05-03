import 'package:flutter/material.dart';
import 'package:whatsapp_chat_app/common/extensions/custom_theme_extension.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;
  final VoidCallback? onTap;
  final double? minWidth;
  const CustomIconButton({
    Key? key,
    required this.icon,
    this.iconColor,
    this.iconSize,
    this.onTap,
    this.minWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      splashColor: Colors.transparent,
      splashRadius: 22,
      iconSize: iconSize ?? 22,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(minWidth: minWidth ?? 40),
      icon: Icon(
        icon,
        color: iconColor ?? context.theme.greyColor,
      ),
    );
  }
}
