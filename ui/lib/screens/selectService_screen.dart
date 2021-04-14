import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/components/treatment_card.dart';
import 'package:ui/screens/diagnosis/breastDiagnosis_screen.dart';
import 'package:ui/screens/diagnosis/lungDiagnosis_screen.dart';
import 'package:ui/screens/diagnosis/skinDiagnosis_screen.dart';
import 'package:ui/screens/home_screen.dart';
import 'package:ui/screens/mainCancer_screen.dart';
import 'diagnosis/skinDiagnosis_screen.dart';

class SelectServiceScreen extends StatefulWidget {
  final diagnosisRoute;
  final prognosisRoute;
  final String cancerType;

  const SelectServiceScreen({@required this.diagnosisRoute, @required this.prognosisRoute, @required this.cancerType});


  @override
  _SelectServiceScreenState createState() => _SelectServiceScreenState();


}

class _SelectServiceScreenState extends State<SelectServiceScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar("arrow", context),
           body: Container(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  left: 22.0,
                  right: 22,
                ),
                child: Center(
                  child: Column(children: [
                    Text(
                      "Select an option",
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 27.0,
                        color: Color(0xFF565D5E),
                      ),
                    ),
                    Text(
                      widget.cancerType,
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 27.0,
                        color: Color(0xFF93ACB1),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => widget.diagnosisRoute,
                          ),
                        );
                      },
                      child: TreatmentCard(cardTitle: 'Diagnosis', cardImage: "diagnosis.jpg",),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "OR",
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 18.0,
                        color: Color(0xFF959595),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => widget.prognosisRoute,
                            ),
                          );
                        },
                        child: TreatmentCard(cardTitle: 'Prognosis', cardImage: 'prognosis.jpg',),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(
                          context
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            decoration: ShapeDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF38819c), Color(0xFF286880)],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            width: 250.0,
                            height: 65.0,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Icon(Icons.arrow_back, color: Colors.white,),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Back To Home Page",
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontFamily: 'Poppins-Regular',
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ),
        ),
      );
  }
}

