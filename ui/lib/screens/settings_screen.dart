import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "settingsScreen";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();

}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar("arrow", context),
          body: Container(
            child: Center(
              child: Column(
                children: [

                  ],
              ),
            ),
          ),
        ));
  }
}
