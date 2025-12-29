import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_pinku_app/data/models/auth/create_user_req.dart';
import 'package:flutter_pinku_app/data/models/auth/signin_user_req.dart';

abstract class AuthFirebaseServise {
  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> signin(SigninUserReq signinUserReq);
}

class AuthFirebaseServiseImpl extends AuthFirebaseServise {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserReq.email,
        password: signinUserReq.password,
      );

      // ignore: avoid_print
      print("Login Successful");

      return Right("Signin Was Successful");
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == "invalid-email") {
        message = "No user found for that email";
      } else if (e.code == "invalid-cradential") {
        message = "Wrong password provided for that user";
      } else {
        message = e.code.toString();
      }

      return left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
        var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

       FirebaseFirestore.instance.collection("Users").add({
        "name" : createUserReq.fullName,
        "email" : data.user?.email
      });

      log("Singup Successful");
      
      return Right("Signup Was Successful");
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == "weak-password") {
        message = "The password provided is too weak";
      } else if (e.code == "email-already-in-use") {
        message = "An account already exists with that email";
      } else {
        message = e.code.toString();
      }

      return left(message);
    }
  }
}
