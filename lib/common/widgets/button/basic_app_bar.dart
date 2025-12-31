import 'package:flutter/material.dart';
import 'package:flutter_pinku_app/common/widgets/button/basic_back_button.dart';
// import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';
//import 'package:flutter_pinku_app/presentation/auth/pages/signup_or_signin.dart';
//import 'package:flutter_pinku_app/presentation/auth/pages/signup_or_signin.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({super.key, this.title, this.hideBackBotton = false});

  final Widget? title;
  final bool hideBackBotton;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: title ?? Text(""),
      leading: hideBackBotton ? null : basicBackButton(context),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
