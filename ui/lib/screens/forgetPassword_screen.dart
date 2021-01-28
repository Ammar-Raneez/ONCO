import 'package:flutter/material.dart';
import 'package:ui/components/RoundedButton.dart';
import 'package:ui/constants.dart';

class ForgetPassword extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "forgetPassword";

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  // variables used
  String favouriteFood;
  String newPassword;
  String confirmPassword;
  String email;

  bool visibleFavouriteFood = false;
  bool visibleNewPassword = false;
  bool visibleConfirmPassword = false;

  var _emailAddressTextFieldController = TextEditingController();
  var _passwordTextFieldController = TextEditingController();
  var _confirmPasswordTextFieldController = TextEditingController();
  var _favouriteFoodSecurityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double keyboardOpenVisibility = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: kBackgroundBlueGradient,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 8.0,
              ),
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: Container(
                    height: 20,
                    child: Image.asset('images/officialLogo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              if (keyboardOpenVisibility == 0.0)
                Flexible(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 150,
                        child: Image.asset('images/clouds.png'),
                      ),
                      Text(
                        "Hi there 👋",
                        textAlign: TextAlign.center,
                        style: kTextStyle.copyWith(
                          color: Color(0xff5b5b5b),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              if (keyboardOpenVisibility == 0.0)
                Text(
                  "Forgot your password?",
                  textAlign: TextAlign.center,
                  style: kTextStyle.copyWith(
                    fontSize: 15,
                  ),
                ),

              TextField(
                controller: _emailAddressTextFieldController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter your email",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
              TextField(
                controller: _passwordTextFieldController,
                obscureText: !visibleNewPassword,
                onChanged: (value) {
                  // track the user new password
                  newPassword = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter New password",
                  prefixIcon: Icon(
                    Icons.lock_outline_sharp,
                    color: Colors.lightBlueAccent,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        visibleNewPassword = !visibleNewPassword;
                      });
                    },
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
              ),

              TextField(
                controller: _confirmPasswordTextFieldController,
                obscureText: !visibleConfirmPassword,
                onChanged: (value) {
                  // track the user confirm password
                  confirmPassword = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter Confirm password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.lightBlueAccent,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        visibleConfirmPassword = !visibleConfirmPassword;
                      });
                    },
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _favouriteFoodSecurityController,
                obscureText: !visibleFavouriteFood,
                onChanged: (value) {
                  // track the user favourite food (security reason question)
                  favouriteFood = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Your favourite food?",
                  prefixIcon: Icon(
                    Icons.security,
                    color: Colors.lightBlueAccent,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        visibleFavouriteFood = !visibleFavouriteFood;
                      });
                    },
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // GO TO THE LOGIN SCREEN
                  Navigator.pop(context);
                },
                child: Text(
                  "<- Back to login",
                  textAlign: TextAlign.end,
                  style: kTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ),
              RoundedButton(
                onPressed: () {
                  //Implement forget password functionality.

                  // clearing the fields once all the data is collected
                  _emailAddressTextFieldController.clear();
                  _passwordTextFieldController.clear();
                  _confirmPasswordTextFieldController.clear();
                  _favouriteFoodSecurityController.clear();

                },
                colour: Colors.lightBlueAccent,
                title: 'SUBMIT',
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
