import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;
  final VoidCallback? onTap;
  final double? minWidth;
  final BoxBorder? border;
  final Color? background;
  const MyIconButton({
    Key? key,
    required this.icon,
    this.iconColor,
    this.iconSize,
    this.onTap,
    this.minWidth,
    this.border,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: border,
      ),
      child: IconButton(
        onPressed: onTap,
        splashColor: Colors.transparent,
        splashRadius: (minWidth ?? 45) - 25,
        iconSize: iconSize ?? 22,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(minWidth: minWidth ?? 45, minHeight: minWidth ?? 45),
        icon: Icon(
          icon,
          color: iconColor ?? Theme.of(context).appBarTheme.iconTheme!.color,
        ),
      ),
    );
  }
}
