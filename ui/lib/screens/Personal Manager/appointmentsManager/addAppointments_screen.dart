import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/screens/Personal%20Manager/appointmentsManager/api/appointmentsFirebaseAPI.dart';
import 'package:ui/screens/Personal%20Manager/appointmentsManager/models/appointment_model.dart';

class AddAppointments extends StatefulWidget {

  AddAppointments(); // Constructor

  @override
  _AddAppointmentsState createState() => _AddAppointmentsState();
}

class _AddAppointmentsState extends State<AddAppointments> {

  // Variables used within file
  String _doctorName = "";
  String _notes = "";
  DateTime _appointmentDate;
  TimeOfDay _appointmentTime;

  FocusNode _nameFocus;
  FocusNode _doseFocus;
  FocusNode _timeFocus;

  @override
  void initState() {

    // initializing focus nodes
    _nameFocus = FocusNode();
    _doseFocus = FocusNode();
    _timeFocus = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar.arrow(context),
        body: SafeArea(
          child: Container(
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
                                "Add Appointment",
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
                              "Enter the details of the Appointment",
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
                        child:Padding(
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
                              padding: const EdgeInsets.symmetric(vertical:8.0),
                              child: Container(

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Color(0xFFEEEEEE)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left:18,
                                              top:5,
                                              bottom: 10,
                                              right: 10
                                          ),
                                          child: TextField(
                                            maxLength: 20,
                                            onChanged: (value) async{
                                              //Check if the field is not empty
                                              if(value !="") {
                                                setState(() {
                                                  _doctorName = value;
                                                });
                                                _doseFocus.requestFocus(); // to move focus to description node
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Name of Doctor", // temporary text
                                              border:InputBorder.none,
                                            ),
                                            style: TextStyle( // text style
                                              fontSize: 15,
                                              fontFamily: 'Poppins-Semibold',
                                              color:Color(0xFF1F1F1F),
                                            ),),
                                        ),
                                      ),

                                    SizedBox(
                                      height: 11,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Color(0xFFEEEEEE)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left:18,
                                            top:5,
                                            bottom: 10,
                                            right: 10
                                        ),
                                        child: TextField(
                                          maxLength: 15,
                                          onChanged: (value) async{
                                            //Check if the field is not empty
                                            if(value !="") {
                                              setState(() {
                                                _notes = value;
                                              });
                                              _timeFocus.requestFocus(); // to move focus to description node
                                            }
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Notes", // temporary text
                                            border:InputBorder.none,
                                          ),
                                          style: TextStyle( // text style
                                            fontSize: 15,
                                            fontFamily: 'Poppins-Semibold',
                                            color:Color(0xFF1F1F1F),
                                          ),),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 11,
                                    ),

                                    GestureDetector(
                                      onTap: () async {

                                        _appointmentDate = DateTime.now();
                                        final DateTime newDate = await showDatePicker(
                                          context: context,
                                          initialDate: _appointmentDate,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2022),
                                          helpText: 'Select a date',);
                                        },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xff01CDFA),
                                          borderRadius: BorderRadius.circular(18),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                                          child: Center(
                                            child: Text(
                                              "Set Date",
                                              style: TextStyle( // text style
                                                fontSize: 15,
                                                fontFamily: 'Poppins-Semibold',
                                                color:Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    GestureDetector(
                                      onTap: () async {

                                        _appointmentTime = TimeOfDay.fromDateTime(DateTime.now());

                                        await showTimePicker(
                                          context: context,
                                          initialTime: _appointmentTime,
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xff01CDFA),
                                          borderRadius: BorderRadius.circular(18),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),

                                          child: Center(
                                            child: Text(
                                              "Set Time",
                                              style: TextStyle( // text style
                                                fontSize: 15,
                                                fontFamily: 'Poppins-Semibold',
                                                color:Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        if(_appointmentTime != null && _appointmentDate != null) {

                                          Appointment newApplication = Appointment(
                                            doctorName: _doctorName,
                                            notes: _notes,
                                            time: _appointmentTime.toString(),
                                            date: _appointmentDate.toString(),
                                          );

                                          AppointmentsFirebaseApi.createAppointment(newApplication);
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: Center(
                                        child: Container(
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE84848),
                                            borderRadius: BorderRadius.circular(18),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top:20,
                                              bottom: 20
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Add Appointment",
                                                style: TextStyle( // text style
                                                  fontSize: 15,
                                                  fontFamily: 'Poppins-Semibold',
                                                  color:Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
