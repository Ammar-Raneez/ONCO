import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ui/constants.dart';

class LungCancerDiagnosis extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "lungCancerDiagnosisScreen";

  @override
  _LungCancerDiagnosisState createState() => _LungCancerDiagnosisState();
}

class _LungCancerDiagnosisState extends State<LungCancerDiagnosis> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff01CDFA),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // HEADER WITH ONCO LOGO AND ICON BUTTON
              Expanded(
                child: Material(
                  color: Color(0xff01CDFA),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                        Image.asset(
                          'images/officialLogo.png',
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // THE REST OF THE BODY CONTENT OF THE SCREEN
              Expanded(
                flex: 6,
                child: Material(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70.0),
                  ),
                  color: Colors.white,

                  // PADDING WIDGET
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // LUNG CANCER DIAGNOSIS TEXT CONTENT
                        Text(
                          "Lung Cancer",
                          style: kTextStyle.copyWith(
                            color: Colors.blueGrey,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          "Diagnosis",
                          style: kTextStyle.copyWith(
                            color: Colors.black54,
                            fontSize: 25,
                          ),
                        ),

                        // DISPLAY THE UPLOADED IMAGE OR CAPTURED IMAGE BY THE USER

                        // CAPTURE(FROM CAMERA) AND UPLOAD(FROM GALLERY) BUTTON

                        // PREDICT BUTTON

                      ],
                    ),
                  ),
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
