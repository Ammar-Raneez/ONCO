import 'package:flutter/material.dart';
import 'package:ui/screens/Personal%20Manager/medicationManager/api/medicationFirebaseAPI.dart';
import 'package:ui/screens/Personal%20Manager/medicationManager/models/medication_model.dart';

class AppointmentsProvider extends ChangeNotifier {
  List<Medication> _medications = [];
  List<Medication> get medications => _medications.toList();

  void setMedications(List<Medication> medications) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _medications = medications;
        notifyListeners();
      });

  void addMedication(Medication medication) => MedicationFirebaseApi.createMedication(medication);

  void removeMedication(Medication medication) => MedicationFirebaseApi.deleteMedication(medication);

  void updateMedication(Medication medication, String medicationName, String dosage, String doseTime) {
    medication.medicationName = medicationName;
    medication.dosage = dosage;
    medication.doseTime = doseTime;
    MedicationFirebaseApi.updateMedication(medication);
  }
}