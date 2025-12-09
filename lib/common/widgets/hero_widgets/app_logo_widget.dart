import 'package:flutter/material.dart';
import 'package:flutter_pinku_app/core/configs/assets/app_vectors.dart';
import 'package:flutter_svg/svg.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key,required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'app-logo',
      child: SvgPicture.asset(
            AppVectors.logo,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
    );
  }
}