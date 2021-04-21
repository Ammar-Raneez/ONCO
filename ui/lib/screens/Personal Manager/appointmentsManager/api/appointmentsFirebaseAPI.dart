import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui/screens/Personal%20Manager/appointmentsManager/models/appointment_model.dart';
import 'package:ui/screens/Personal%20Manager/utils.dart';
import 'package:ui/services/GoogleUserSignInDetails.dart';

final _firestore = FirebaseFirestore.instance;

final user = FirebaseAuth.instance.currentUser;

var loggedInUserEP = user.email;
var loggedInUserGoogle =  GoogleUserSignInDetails.googleSignInUserEmail;

class AppointmentsFirebaseApi {

  static Future<String> createAppointment(Appointment appointment) async {
    final docAppointment = _firestore
        .collection("appointment")
        .doc(loggedInUserEP != null ? loggedInUserEP : loggedInUserGoogle)
        .collection("appointments")
        .doc();

    appointment.id = docAppointment.id;
    await docAppointment.set(appointment.toJson());
    return docAppointment.id;
  }

  static Stream<List<Appointment>> readAppointment() => FirebaseFirestore.instance
      .collection("appointment")
      .doc(loggedInUserEP != null ? loggedInUserEP : loggedInUserGoogle)
      .collection("appointments")
      .snapshots()
      .transform(Utils.transformer(Appointment.fromJson)
  );

  static Future deleteAppointment(Appointment appointment) async {
    final docAppointment = FirebaseFirestore.instance
        .collection('appointment')
        .doc(loggedInUserEP != null ? loggedInUserEP : loggedInUserGoogle)
        .collection("appointments")
        .doc(appointment.id);

    await docAppointment.delete();
  }
}