// import 'package:google_sign_in/google_sign_in.dart';

class GoogleUserSignInDetails{

  static String googleSignInUserEmail;

  // setter
  static void setGoogleSignInUser(String email){
    googleSignInUserEmail = email;
  }

  // getter
  static String getGoogleSignInUser(){
   return googleSignInUserEmail;
  }

}