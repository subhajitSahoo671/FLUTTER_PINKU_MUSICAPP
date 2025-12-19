import 'package:flutter/material.dart';
import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';
//import 'package:flutter_pinku_app/presentation/auth/pages/signup_or_signin.dart';
//import 'package:flutter_pinku_app/presentation/auth/pages/signup_or_signin.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({super.key, this.title,});

  final Widget? title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: title ?? Text(""),
      leading: IconButton(
        style: ButtonStyle(
          //iconSize: WidgetStateProperty.all(14),
          overlayColor: WidgetStateProperty.all(
            AppColors.primary.withAlpha(30),
          ),
        ),
        icon: CircleAvatar(
          backgroundColor: AppColors.greyText.withAlpha(30),
          radius: 20,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).primaryTextTheme.bodyMedium?.color,
            size: 14,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
