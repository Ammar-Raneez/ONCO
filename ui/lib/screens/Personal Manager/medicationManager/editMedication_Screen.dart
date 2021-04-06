import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/components/medication_card.dart';
import 'package:ui/screens/Personal%20Manager/api/medicationFirebaseAPI.dart';
import 'package:ui/screens/Personal%20Manager/api/medicationsProvider.dart';
import 'package:ui/screens/Personal%20Manager/models/medication_model.dart';


class EditMedication extends StatefulWidget {

  final Medication medication;
  EditMedication({@required this.medication}); // Constructor

  @override
  _EditMedicationState createState() => _EditMedicationState();
}

class _EditMedicationState extends State<EditMedication> {

  // Variables used within file
  String _medicationName;
  String _medicationDose;
  String _medicationTime;
  // var name = TextEditingController();
  // var dose = TextEditingController();
  // var time = TextEditingController();

  @override
  void initState() {
    super.initState();

    _medicationName = widget.medication.medicationName;
    _medicationDose = widget.medication.dosage;
    _medicationTime = widget.medication.doseTime;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                            "Edit Medication",
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
                            "Edit the details of the medication, Click on the delete icon to delete the medication",
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
                                      child: TextFormField(
                                        initialValue: _medicationName,
                                        maxLength: 20,
                                          onChanged: (value) async{
                                          //Check if the field is not empty
                                          if(value !="") {
                                            setState(() {
                                              _medicationName = value;
                                            });

                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Name of Medication", // temporary text
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
                                      child: TextFormField(
                                        initialValue: _medicationDose,
                                        maxLength: 15,
                                        onChanged: (value) async{
                                          //Check if the field is not empty
                                          if(value !="") {
                                            setState(() {
                                              _medicationDose = value;
                                            });

                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Dose - eg: 'Two tablets', '5 ml'", // temporary text
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
                                      child: TextFormField(
                                        initialValue: _medicationTime,
                                        maxLength: 35,
                                        onChanged: (value) async{
                                          //Check if the field is not empty
                                          if(value !="") {
                                            setState(() {
                                              _medicationTime = value;
                                            });

                                            // _doseFocus.requestFocus(); // to move focus to description node
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Time - eg: 'every 5 hours','after lunch'", // temporary text
                                          border:InputBorder.none,
                                        ),
                                        style: TextStyle( // text style
                                          fontSize: 15,
                                          fontFamily: 'Poppins-Semibold',
                                          color:Color(0xFF1F1F1F),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      if(_medicationName !="") {
                                        Medication _newMedication = Medication(
                                          medicationName: _medicationName,
                                          dosage: _medicationDose,
                                          doseTime: _medicationTime,
                                        );
                                        MedicationFirebaseApi.createMedication(_newMedication);
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: Center(
                                      child: Container(
                                        width: 200,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF1F1F1F),
                                          borderRadius: BorderRadius.circular(18),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top:20,
                                              bottom: 20
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Add Medication",
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
                                  ),
                                ],
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

                    final provider = Provider.of<MedicationProvider>(context, listen: false);
                    provider.removeMedication(widget.medication);

                    Navigator.pop(context);
                    setState(() {}); // Setting and Refreshing State
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0xFFE84848),
                        borderRadius: BorderRadius.circular(18)
                    ),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )
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
