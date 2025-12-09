//import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/common/widgets/button/basic_app_button.dart';
import 'package:flutter_pinku_app/common/widgets/hero_widgets/app_logo_widget.dart';
import 'package:flutter_pinku_app/core/configs/assets/app_images.dart';
//import 'package:flutter_pinku_app/core/configs/assets/app_vectors.dart';
//import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';
import 'package:flutter_pinku_app/presentation/auth/pages/signup_or_signin.dart';
import 'package:flutter_pinku_app/presentation/choose_mode/widgets/mode_widgets.dart';
//import 'package:flutter_pinku_app/presentation/choose_mode/bloc/theme_cubit.dart';
//import 'package:flutter_pinku_app/presentation/intro/pages/get_started.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.modeBG),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withAlpha(120)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: Column(
                children: [
                  //  Padding(padding: EdgeInsets.only(top: 15)),
                  Align(
                    alignment: Alignment.topCenter,
                    child: AppLogoWidget(width: 60, height: 60)
                  ),
                  Spacer(),
                  Text(
                    "Choose Mode",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  ModeWidgets(),
                  SizedBox(height: 60),
                  BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SignupOrSignin(),
                        ),
                      );
                    },
                    title: "Continue",
                  ),
                  SizedBox(height: 35),
                ],
              ),
          ),
        ],
      ),
    );
  }
}