import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/medication_card.dart';
import 'package:ui/screens/Personal%20Manager/medicationManager/api/medicationsProvider.dart';

class ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MedicationProvider>(context);
    final medications = provider.medications;

    return medications.isEmpty
        ? Center(
      child: Text(
        'No Medications.',
        style: TextStyle(
          color: Color(0xffaaaaaa),
          fontFamily: 'Poppins-SemiBold',
          fontSize: 17,
        ),
      ),
    )
        : ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Container(height: 5),
      itemCount: medications.length,
      itemBuilder: (context, index) {
        final medication = medications[index];

        return MedicationCard(medication: medication);
      },
    );
  }
}