import 'package:flutter/material.dart';
import 'package:flutter_pinku_app/common/widgets/button/basic_app_button.dart';
import 'package:flutter_pinku_app/core/configs/assets/app_images.dart';
import 'package:flutter_pinku_app/core/configs/assets/app_vectors.dart';
import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';
import 'package:flutter_pinku_app/presentation/choose_mode/pages/choose_mode.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.introBG),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withAlpha(80)),
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
                    "Enjoy Listening To Music",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 35),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam.",
                    style: TextStyle(
                      color: AppColors.greyText,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 45),
                  BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ChooseModePage(),
                        ),
                      );
                    },
                    title: "Get Started",
                  ),
                  SizedBox(height: 40),
                ],
              ),
          ),
        ],
      ),
    );
  }
}
