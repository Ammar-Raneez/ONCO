import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/components/medication_card.dart';
import 'package:ui/components/widgets.dart';
import 'file:///C:/Users/hamma/Documents/GitHub/SDGP-ONCO/ui/lib/screens/Personal%20Manager/medicationManager/addMedication_screen.dart';
import 'api/medicationFirebaseAPI.dart';
import 'api/medicationsProvider.dart';
import 'editMedication_Screen.dart';
import 'medicationWidgets/MedicationListWidget.dart';
import 'models/medication_model.dart';

class MedicationManager extends StatefulWidget {
  @override
  _MedicationManagerState createState() => _MedicationManagerState();

  final  Medication medication;
  MedicationManager({@required this.medication}); // Constructor
}

class _MedicationManagerState extends State<MedicationManager> {

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [

              Column(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 0
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            // color: Color(0xFF57994D)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(

                              child: StreamBuilder<List<Medication>>(
                                  stream: MedicationFirebaseApi.readMedication(),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return Center(
                                            child: CircularProgressIndicator());
                                      default:
                                        if (snapshot.hasError) {
                                          return buildText(
                                              'Something went wrong, Try later');
                                        } else {
                                          final medications = snapshot.data;

                                          final provider = Provider.of<MedicationProvider>(context);
                                          provider.setMedications(medications);

                                          return MedicationListWidget();
                                        }
                                    }
                                  }
                              ),

                            ),
                          ),
                        ),
                      )
                  ),

                ],
              ),
              Positioned(
                bottom: 17,
                right: 17,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddMedication() // Navigates to Task Page
                      ),
                    ).then((value) {
                      setState(() {}); // Setting and Refreshing State
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0xFF1c374a),
                        borderRadius: BorderRadius.circular(18)
                    ),
                    child: Image(
                        image: AssetImage('images/add_icon.png') // Add icon
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
// }

Widget buildText(String text) => Center(
  child: Text(
    text,
    style: TextStyle(fontSize: 24, color: Colors.white),
  ),
);

void editMedication(BuildContext context, Medication medication) => Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => EditMedication(medication: medication),
  ),
);