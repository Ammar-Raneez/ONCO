import 'package:flutter/material.dart';

class MedicationCard extends StatelessWidget {

  final String medicationTitle;
  final String medicationDose;

  MedicationCard({@required this.medicationTitle,@required this.medicationDose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical:5.0,
        horizontal: 10
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 14.0,
                top: 15,
                bottom: 15
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicationTitle,
                  style: TextStyle(
                      fontFamily: 'Poppins-SemiBold',
                      fontSize: 17,
                      color: Color(0xFF3A6B8D)
                  ),
                ),
                Text(
                  medicationDose,
                  style: TextStyle(
                      fontFamily: 'Poppins-SemiBold',
                      fontSize: 13,
                      color: Color(0xFF5C87A4)
                  ),
                )
              ],
            ),
          ),
        ),

      ),
    );
  }
}
