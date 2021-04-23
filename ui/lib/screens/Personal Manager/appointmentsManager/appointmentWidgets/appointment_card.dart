import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/screens/Personal%20Manager/appointmentsManager/api/appointmentsProvider.dart';
import 'package:ui/screens/Personal%20Manager/appointmentsManager/models/appointment_model.dart';

class AppointmentsCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentsCard({
    @required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xFFCDDDF6)),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0, top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.doctorName,
                        style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 17,
                            color: Color(0xFF3A6B8D)),
                      ),
                      Text(
                        appointment.notes,
                        style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 13,
                            color: Color(0xFF5C87A4)),
                      )
                    ],
                  ),
                  IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        /* Connecting to Provider and using removeAppointment method to remove
                         * the Appointment from Firebase
                         */
                        final provider = Provider.of<AppointmentsProvider>(
                            context,
                            listen: false);
                        provider.removeAppointment(appointment);

                        Navigator.pop(context);
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
