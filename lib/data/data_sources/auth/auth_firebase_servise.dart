import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_pinku_app/data/models/auth/create_user_req.dart';

abstract class AuthFirebaseServise {

  Future<Either> signup(CreateUserReq createUserReq);

  Future<void> signin();
}

class AuthFirebaseServiseImpl extends AuthFirebaseServise{
  @override
  Future<void> signin() {
   
    throw UnimplementedError();
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
   try {
     
     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: createUserReq.email, 
     password: createUserReq.password);

     return Right("Signup Was Successful");

   } on FirebaseAuthException catch (e) {
     String message = "";


    if (e.code == "weak-password") {
      message = "The password provided is too weak";
    } else if (e.code == "email-already-in-use"){
      message = "An account already exists with that email";
    }

     return left(message);
   }
  }
  
}