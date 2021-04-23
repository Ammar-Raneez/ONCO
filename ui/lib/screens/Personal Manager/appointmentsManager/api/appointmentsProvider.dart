import 'package:flutter/material.dart';
import 'package:ui/screens/Personal%20Manager/appointmentsManager/api/appointmentsFirebaseAPI.dart';
import 'package:ui/screens/Personal%20Manager/appointmentsManager/models/appointment_model.dart';

class AppointmentsProvider extends ChangeNotifier {
  List<Appointment> _appointments = [];

  List<Appointment> get appointments => _appointments;

  void setAppointments(List<Appointment> appointment) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _appointments = appointment;
        notifyListeners();
      });

  void addMedication(Appointment appointment) =>
      AppointmentsFirebaseApi.createAppointment(appointment);

  void removeAppointment(Appointment appointment) =>
      AppointmentsFirebaseApi.deleteAppointment(appointment);
}
