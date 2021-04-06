import 'package:flutter/material.dart';
import 'package:ui/screens/Personal%20Manager/api/utils.dart';

class MedicationTime {
  static const createdTime = 'createdTime';
}

class Medication {

  String id;
  String medicationName;
  String dosage;
  String doseTime;

  Medication({
    @required this.medicationName,
    this.dosage = '',
    this.doseTime='',
    this.id,
  }); // Constructor

  static Medication fromJson(Map<String, dynamic> json) => Medication(
    medicationName: json['medicationName'],
    dosage: json['dosage'],
    doseTime: json['doseTime'],
    id: json['id'],
  );

  Map<String, dynamic> toJson() => {
    'medicationName': medicationName,
    'dosage': dosage,
    'doseTime': doseTime,
    'id': id,
  };

}