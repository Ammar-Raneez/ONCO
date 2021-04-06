import 'package:flutter/material.dart';
import 'package:ui/screens/Personal%20Manager/editMedication_Screen.dart';
import 'package:ui/screens/Personal%20Manager/models/medication_model.dart';

class MedicationCard extends StatelessWidget {

  final Medication medication;

  const MedicationCard({
    @required this.medication,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => editMedication(context, medication),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical:5.0,
          horizontal: 0
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xFFCDDDF6)
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
                    medication.medicationName,
                    style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 17,
                        color: Color(0xFF3A6B8D)
                    ),
                  ),
                  Text(
                    medication.dosage + " "+ medication.doseTime,
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
      ),
    );
  }
}

void editMedication(BuildContext context, Medication medication) => Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => EditMedication(medication: medication),
  ),
);
