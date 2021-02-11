import 'package:google_sign_in/google_sign_in.dart';

class GoogleUserSignInDetails{

  static String googleSignInUserEmail;

  // setter
  void setGoogleSignInUser(String email){
    googleSignInUserEmail = email;
  }

  // getter
  String getGoogleSignInUser(){
   return googleSignInUserEmail;
  }

}