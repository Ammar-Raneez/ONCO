import 'package:flutter/material.dart';
import 'package:ui/components/RoundedButton.dart';
import 'package:ui/constants.dart';

class RegistrationScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "registerScreen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String username;
  String email;
  String password;
  String favoriteFood;

  bool visibleFavouriteFood = false;
  bool visiblePassword = false;

  var _usernameController = TextEditingController();
  var _passwordTextFieldController = TextEditingController();
  var _emailAddressController = TextEditingController();
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
                        "Nice to see you here 👋",
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
                  "Register an Account",
                  textAlign: TextAlign.center,
                  style: kTextStyle.copyWith(
                    fontSize: 15,
                  ),
                ),
              TextField(
                controller: _usernameController,
                onChanged: (value) {
                  username = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter Username",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
              TextField(
                controller: _emailAddressController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter Email Address",
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
              TextField(
                controller: _passwordTextFieldController,
                obscureText: !visiblePassword,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter Password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.lightBlueAccent,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        visiblePassword = !visiblePassword;
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
                  favoriteFood = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Your favourite food?",
                  prefixIcon:
                      Icon(Icons.security, color: Colors.lightBlueAccent),
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
                  //Implement Change password functionality.
                  print("Username: " + username);
                  print("Email Address: " + email);
                  print("Enter Password: " + password);
                  print("Enter favourite food: " + favoriteFood);

                  // clearing the content of the field once submitted
                  _favouriteFoodSecurityController.clear();
                  _emailAddressController.clear();
                  _usernameController.clear();
                  _passwordTextFieldController.clear();
                },
                colour: Colors.lightBlueAccent,
                title: 'REGISTER ACCOUNT',
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
