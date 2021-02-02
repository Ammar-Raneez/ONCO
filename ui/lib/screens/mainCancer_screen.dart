import 'package:flutter/material.dart';
import 'package:ui/components/cancer_card.dart'; //imports card component

//TODO -  add top appbar/row and add functionality for passing colors into card. Might need to adjust padding after adding appbar

/* This is the Cancer Page that displays an appbar with a gradient and a logo, three cards that allow the user to click on a
 certain cancer and be redirected to that page and the nav at the bottom. */

class MainCancerTypesScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "mainCancerTypesScreen";

  @override
  _MainCancerTypesScreenState createState() => _MainCancerTypesScreenState();
}

class _MainCancerTypesScreenState extends State<MainCancerTypesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            //* might need to change when adding top row and nav
            top: 120.0,
            left: 24.0,
            right: 24.0,
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Prognosis and Diagnosis of Cancers',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                CancerCard(cardTitle: 'Skin Cancer.'),
                //generates a cancer card with text passed.
                SizedBox(
                  height: 32,
                ),
                CancerCard(cardTitle: 'Lung Cancer.'),
                SizedBox(
                  height: 32,
                ),
                CancerCard(cardTitle: 'Breast Cancer.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
