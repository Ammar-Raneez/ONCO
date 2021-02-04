import 'package:flutter/material.dart';
import 'package:ui/components/cancer_card.dart'; //imports card component
import 'package:ui/components/custom_app_bar.dart';

//TODO - Add nav to bottom also add passing colors into card. Might need to adjust padding after(Appbar done only for nav)

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
      appBar: CustomAppBar("settings"),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            //* might need to change when adding top row and nav
            left: 33.0,
            right: 36.0,
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Prognosis & Diagnosis of Cancers',
                  style: TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 27.0,
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                CancerCard(cardTitle: 'Skin Cancer'),
                //generates a cancer card with text passed.
                SizedBox(
                  height: 15,
                ),
                CancerCard(cardTitle: 'Lung Cancer'),
                SizedBox(
                  height: 12,
                ),
                CancerCard(cardTitle: 'Breast Cancer'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}