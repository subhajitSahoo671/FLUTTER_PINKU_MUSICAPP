import 'package:flutter/material.dart';

import 'package:flutter_pinku_app/common/widgets/button/basic_app_bar.dart';
import 'package:flutter_pinku_app/common/widgets/button/basic_app_button.dart';
import 'package:flutter_pinku_app/common/widgets/hero_widgets/app_logo_widget.dart';
import 'package:flutter_pinku_app/presentation/auth/pages/signup.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: _signInText(),
      persistentFooterButtons: [_signInText(context)],
      persistentFooterDecoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent.withAlpha(2),
            blurRadius: 5,
            offset: Offset(0, -5),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: Colors.purpleAccent.withAlpha(200),
            width: 0.5,
          ),
        ),
      ),
      appBar: BasicAppBar(title: AppLogoWidget(width: 45, height: 45)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              _signinText(),
              SizedBox(height: 40),
              _emailField(context),
              SizedBox(height: 20),
              _passwordField(),
              SizedBox(height: 40),
              BasicAppButton(onPressed: () {}, title: "Create Account"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signinText() {
    return Text(
      "Sign In",
      style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: "Enter Email",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField() {
    return TextField(decoration: InputDecoration(labelText: "Password"));
  }

  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Not A Member? ",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: () {
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return  SignupPage();
                              },));
            },
            child: Text(
              "Register Now",
              style: TextStyle(
                fontSize: 14,
                //color: AppColors.primary.withValues(blue: 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
