import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/common/widgets/button/basic_app_button.dart';
import 'package:flutter_pinku_app/core/configs/assets/app_images.dart';
import 'package:flutter_pinku_app/core/configs/assets/app_vectors.dart';
import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';
import 'package:flutter_pinku_app/presentation/auth/pages/signup_or_signin.dart';
import 'package:flutter_pinku_app/presentation/choose_mode/bloc/theme_cubit.dart';
//import 'package:flutter_pinku_app/presentation/intro/pages/get_started.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                    child: SvgPicture.asset(
                      AppVectors.logo,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
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
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                            },
                            child: ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: Color(0xff30393C).withValues(alpha: 0.2),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.nightlight_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Dark Mode",
                            style: TextStyle(
                              color: AppColors.greyText,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 75),
                       Column(
                         children: [
                           GestureDetector(
                              onTap: () {
                                context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                              },
                             child: ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: Color(0xff30393C).withValues(alpha: 0.2),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.light_mode_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                                                       ),
                           ),
                          SizedBox(height: 15),
                          Text(
                            "Light Mode",
                            style: TextStyle(
                              color: AppColors.greyText,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                         ],
                       ),
                    ],
                 ),
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