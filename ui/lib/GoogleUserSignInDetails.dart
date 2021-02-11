import 'package:google_sign_in/google_sign_in.dart';

class GoogleUserSignInDetails{

  GoogleSignIn googleSignInUser;

  // setter
  void setGoogleSignInUser(GoogleSignIn user){
    this.googleSignInUser = user;
  }

  // getter
  GoogleSignIn getGoogleSignInUser(){
    return googleSignInUser;
  }

}