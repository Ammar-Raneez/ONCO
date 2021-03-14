import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/components/medication_card.dart';

import 'addMedication_screen.dart';

class MedicationManager extends StatefulWidget {
  @override
  _MedicationManagerState createState() => _MedicationManagerState();
}

class _MedicationManagerState extends State<MedicationManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                      "Medications",
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
                      "Here you can manage your medications, click add a medication to create one and drag the medication to delete it",
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
                    vertical: 10
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color(0xFF57994D)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:8.0),
                      child: Container(
                          child:ListView(
                          children:[
                            Column(
                              children: [
                                MedicationCard(medicationTitle: "Panadol", medicationDose: "2 times every 8 hours",),
                                MedicationCard(medicationTitle: "Banana", medicationDose: "2 times every 8 hours",),
                                MedicationCard(medicationTitle: "Panadol", medicationDose: "2 times every 8 hours",),
                              ],
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
      ),
    );
  }
}
