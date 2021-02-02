import 'package:flutter/material.dart';

//TODO add top appbar/row and add

class CancerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
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
                SizedBox(height: 32,),
                CancerCard(cardTitle: 'Skin Cancer.'),
                SizedBox(height: 32,),
                CancerCard(cardTitle: 'Lung Cancer.'),
                SizedBox(height: 32,),
                CancerCard(cardTitle: 'Breast Cancer.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

