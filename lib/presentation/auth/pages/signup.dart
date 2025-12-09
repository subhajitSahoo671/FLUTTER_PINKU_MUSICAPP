import 'package:flutter/material.dart';
import 'package:flutter_pinku_app/common/widgets/button/basic_app_bar.dart';
import 'package:flutter_pinku_app/common/widgets/hero_widgets/app_logo_widget.dart';
//import 'package:flutter_pinku_app/core/configs/assets/app_vectors.dart';
//import 'package:flutter_svg/svg.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: AppLogoWidget(width: 47, height: 47)
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            _registerText(),
            SizedBox(height: 40,),
            _fullNameField(context),
            SizedBox(height: 20,),
            _emailField(),
            SizedBox(height: 20,),
            _passwordField(),
          ],
        ),
      ),
    );
  }

  Widget _registerText(){
    return Text(
      "Register",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
  
  Widget _fullNameField(BuildContext context){
    return TextField(
      decoration: InputDecoration(
        labelText: "Full Name",
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      )
    );
  }

  Widget _emailField(){
    return TextField(
      decoration: InputDecoration(
        labelText: "Enter Email",
      ),
    );
  }

  Widget _passwordField(){
    return TextField(
      decoration: InputDecoration(
        labelText: "Password",
      ),
    );
  }
}