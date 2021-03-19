import 'package:flutter/material.dart';
import 'package:ui/components/treatment_card.dart';

class SelectServiceScreen extends StatefulWidget {
  @override
  _SelectServiceScreenState createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              left: 33.0,
              right: 36.0,
            ),
            child: Center(
              child: Column(children: [
                Text(
                  "Select an option",
                  style: TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 27.0,
                    color: Color(0xFF565D5E),
                  ),
                ),
                Text(
                  "Type Of Cancer",
                  style: TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 27.0,
                    color: Color(0xFF93ACB1),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                TreatmentCard(cardTitle: 'Diagnosis'),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "OR",
                  style: TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 18.0,
                    color: Color(0xFF959595),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                TreatmentCard(cardTitle: 'Prognosis'),
                SizedBox(
                  height: 46,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF01D1FF), Color(0xFF006377)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                    ),
                     padding: EdgeInsets.only(left: 10.0, right: 10.0),
                     width: 250.0,
                    height: 65.0,
                    child: Row(
                      children: [
                        new Icon(Icons.arrow_back),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          "Back To Home Page",
                          style: TextStyle(
                              fontSize: 17.0, fontFamily: 'Poppins-Regular', color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
