import 'package:flutter/material.dart';

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
              Expanded(
                flex: 6,
                child: Material(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(70.0),
                  ),
                  color: Colors.white,
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
