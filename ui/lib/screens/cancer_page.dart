import 'package:flutter/material.dart';
import 'package:ui/components/cancer_card.dart'; //imports card component

//TODO add top appbar/row and add functionality for passing colors into card.

/* This is the Cancer Page that displays an appbar with a gradient and a logo, three cards that allow the user to click on a
 certain cancer and be redirected to that page and the nav at the bottom. */
class CancerPage extends StatelessWidget {
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
