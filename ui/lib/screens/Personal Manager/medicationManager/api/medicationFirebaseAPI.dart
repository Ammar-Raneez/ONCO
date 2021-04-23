import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui/screens/Personal%20Manager/medicationManager/models/medication_model.dart';
import 'package:ui/screens/Personal%20Manager/utils.dart';
import 'package:ui/services/GoogleUserSignInDetails.dart';

final _firestore = FirebaseFirestore.instance;

final user = FirebaseAuth.instance.currentUser;

var loggedInUserEP = user.email;
var loggedInUserGoogle = GoogleUserSignInDetails.googleSignInUserEmail;

class MedicationFirebaseApi {
  static Future<String> createMedication(Medication medication) async {
    final docMedication = _firestore
        .collection("medication")
        .doc(loggedInUserEP != null ? loggedInUserEP : loggedInUserGoogle)
        .collection("medications")
        .doc();
    medication.id = docMedication.id;
    await docMedication.set(medication.toJson());
    return docMedication.id;
  }

  static Stream<List<Medication>> readMedication() => FirebaseFirestore.instance
      .collection("medication")
      .doc(loggedInUserEP != null ? loggedInUserEP : loggedInUserGoogle)
      .collection("medications")
      .snapshots()
      .transform(Utils.transformer(Medication.fromJson));

  static Future updateMedication(Medication medication) async {
    final docMedication = FirebaseFirestore.instance
        .collection('medication')
        .doc(loggedInUserEP != null ? loggedInUserEP : loggedInUserGoogle)
        .collection("medications")
        .doc(medication.id);

    await docMedication.update(medication.toJson());
  }

  static Future deleteMedication(Medication medication) async {
    final docMedication = FirebaseFirestore.instance
        .collection('medication')
        .doc(loggedInUserEP != null ? loggedInUserEP : loggedInUserGoogle)
        .collection("medications")
        .doc(medication.id);

    await docMedication.delete();
  }
}
