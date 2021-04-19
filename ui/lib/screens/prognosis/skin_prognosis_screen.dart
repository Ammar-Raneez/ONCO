import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/constants.dart';
import 'package:ui/services/UserDetails.dart';
import 'dart:io';

class SkinPrognosisScreen extends StatefulWidget {
  @override
  _SkinPrognosisScreenState createState() => _SkinPrognosisScreenState();
}

class _SkinPrognosisScreenState extends State<SkinPrognosisScreen> {
  List<String> questions;
  List<List<String>> radioOptions;
  TextEditingController userAge = new TextEditingController();

  @override
  void initState() {
    super.initState();

    if (UserDetails.getUserData()['gender'] == "male") {
      questions = SKIN_CANCER_PROGNOSIS_QUESTIONS_MALE;
      radioOptions = SKIN_CANCER_PROGNOSIS_ANSWER_OPTIONS_MALE;
      // print(questions);
    } else {
      questions = SKIN_CANCER_PROGNOSIS_QUESTIONS_FEMALE;
      radioOptions = SKIN_CANCER_PROGNOSIS_ANSWER_OPTIONS_FEMALE;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: ModalProgressHUD(
        // displaying the spinner for async tasks
        inAsyncCall: false,
        child: Scaffold(
          appBar: CustomAppBar.arrow(context),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // THE REST OF THE BODY CONTENT OF THE SCREEN
                Expanded(
                  flex: 6,
                  child: Material(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // LUNG CANCER DIAGNOSIS TEXT CONTENT
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Skin Cancer",
                            style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 27.0,
                              color: Color(0xFF93ACB1),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Prognosis",
                            style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 27.0,
                              color: Color(0xFF565D5E),
                            ),
                          ),
                        ),

                        // DISPLAY THE UPLOADED IMAGE OR CAPTURED IMAGE BY THE USER
                        Expanded(
                          child: SingleChildScrollView(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                for (var q in questions)
                                  Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blue),
                                      margin: const EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 10,
                                          bottom: 10),
                                      width: width,
                                      child: Column(
                                        children: [
                                          Text(
                                            q ,
                                            style: TextStyle(
                                              fontFamily: 'Poppins-SemiBold',
                                              fontSize: 18.0,
                                              color: Color(0xFFFFFFFF),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          q == "Age"
                                              ? TextField(
                                                  controller: userAge,
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Colors
                                                                    .white),
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(16),
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Colors
                                                                    .white),
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(16),
                                                      ),
                                                      hintText:
                                                          'Enter your age'),
                                                )
                                              : Text(
                                                  q,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Poppins-SemiBold',
                                                    fontSize: 18.0,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                        ],
                                      )),
                              ],
                            ),
                          )),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0)),
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 50, right: 50),
                          child: RawMaterialButton(
                            fillColor: Colors.black54,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  SizedBox(
                                    width: 10.0,
                                    height: 30.0,
                                  ),
                                  Text(
                                    "PREDICT",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Regular',
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            shape: const StadiumBorder(),
                            onPressed: () {
                              // PERFORM PREDICTION
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
