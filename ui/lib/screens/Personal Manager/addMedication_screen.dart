import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/components/medication_card.dart';
import 'package:ui/screens/Personal%20Manager/models/medication_model.dart';

class AddMedication extends StatefulWidget {
  // final Medication medication;
  // AddMedication({@required this.medication});

  @override
  _AddMedicationState createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [

              Column(
                children: [
                  CustomAppBar("arrow", context),
                  Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          bottom: 8,
                        ),
                        child: Align(

                          alignment: Alignment.topLeft,
                          child: Text(
                            "Add a Medication",
                            style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20,
                            right: 20
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Enter the details of the medication, click the delete button to remove the medication",
                            style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontSize: 13.0,
                                color: Color(0xFF3C707B)
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),

                  Expanded(
                      child:Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 0
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            // color: Color(0xFF57994D)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical:8.0),
                            child: Container(

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListView(
                                children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFFCDDDF6)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left:18,
                                            top:5,
                                            bottom: 10,
                                            right: 10
                                        ),
                                        child: TextField(
                                          maxLength: 20,
                                          decoration: InputDecoration(
                                            hintText: "Name of Medication", // temporary text
                                            border:InputBorder.none,
                                          ),
                                          style: TextStyle( // text style
                                            fontSize: 15,
                                            fontFamily: 'Poppins-Semibold',
                                            color:Color(0xFF1F1F1F),
                                          ),),
                                      ),
                                    ),

                                  SizedBox(
                                    height: 11,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFFCDDDF6)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left:18,
                                          top:5,
                                          bottom: 10,
                                          right: 10
                                      ),
                                      child: TextField(
                                        maxLength: 15,
                                        decoration: InputDecoration(
                                          hintText: "Dose - eg: 'Two tablets', '5 ml'", // temporary text
                                          border:InputBorder.none,
                                        ),
                                        style: TextStyle( // text style
                                          fontSize: 15,
                                          fontFamily: 'Poppins-Semibold',
                                          color:Color(0xFF1F1F1F),
                                        ),),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 11,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFFCDDDF6)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left:18,
                                          top:5,
                                          bottom: 10,
                                          right: 10
                                      ),
                                      child: TextField(
                                        maxLength: 35,
                                        decoration: InputDecoration(
                                          hintText: "Time - eg: 'every 5 hours','after lunch'", // temporary text
                                          border:InputBorder.none,
                                        ),
                                        style: TextStyle( // text style
                                          fontSize: 15,
                                          fontFamily: 'Poppins-Semibold',
                                          color:Color(0xFFE84848),
                                        ),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                  ),

                ],
              ),
              Positioned(
                bottom:17,
                right: 17,
                child: GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0xFF1c374a),
                        borderRadius: BorderRadius.circular(18)
                    ),
                    child: Image(
                        image:AssetImage('images/add_icon.png') // Add icon
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
