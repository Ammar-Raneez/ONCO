import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/components/medication_card.dart';
import 'package:ui/components/widgets.dart';
import 'addAppointments_screen.dart';
import 'api/appointmentsFirebaseAPI.dart';
import 'api/appointmentsProvider.dart';
import 'models/appointment_model.dart';

class AppointmentsManager extends StatefulWidget {
  @override
  _AppointmentsManagerState createState() => _AppointmentsManagerState();

  Appointment medication;
  AppointmentsManager(); // Constructor
}

class _AppointmentsManagerState extends State<AppointmentsManager> {

    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar.arrow(context),
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
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
                              "Appointments",
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
                              "Here you can manage your Appointments, click add a medication to create one and drag the Appointment to delete it",
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


                                ),

                              ),
                            ),
                          ),
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
                                    AddAppointments() // Navigates to Task Page
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

void editMedication(BuildContext context, Appointment medication) => Navigator.of(context).push(
  MaterialPageRoute(
    //builder: (context) => EditMedication(medication: medication),
  ),
);