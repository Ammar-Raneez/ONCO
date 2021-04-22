import 'package:flutter/material.dart';
class Appointment {

  String id;
  String doctorName;
  String notes;
  String date;
  String time;

  Appointment({
    @required
    this.doctorName,
    this.notes = '',
    this.date = '',
    this.time = '',
    this.id,
  }); // Constructor

  static Appointment fromJson(Map<String, dynamic> json) => Appointment(
    doctorName: json['doctorName'],
    notes: json['notes'],
    date: json['date'],
    time: json['time'],
    id: json['id'],
  );

  Map<String, dynamic> toJson() => {
    'doctorName': doctorName,
    'notes': notes,
    'date': date,
    'time': time,
    'id': id,
  };
}