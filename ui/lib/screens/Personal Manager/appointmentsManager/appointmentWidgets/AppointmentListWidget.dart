import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/screens/Personal%20Manager/appointmentsManager/api/appointmentsProvider.dart';
import 'package:ui/screens/Personal%20Manager/appointmentsManager/appointmentWidgets/appointment_card.dart';

class AppointmentsListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppointmentsProvider>(context);
    final appointments = provider.appointments;

    /* Returning Either a ListView with all Appointments from Firebase
     * or either a Text with no Appointments if nothing has been added (isEmpty)
     */
    return appointments.isEmpty
        ? Center(
            child: Text(
              'No Appointments.',
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
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];

              return AppointmentsCard(appointment: appointment);
            },
          );
  }
}
