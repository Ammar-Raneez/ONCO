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
                Text("Select an option", style: TextStyle(
                  fontFamily: 'Poppins-SemiBold',
                  fontSize: 27.0,
                  color: Color(0xFF565D5E),
                ),
                ),
                Text("Type Of Cancer", style: TextStyle(
                  fontFamily: 'Poppins-SemiBold',
                  fontSize: 27.0,
                  color: Color(0xFF93ACB1),
                ),
                ),
                SizedBox(height: 15,),
                TreatmentCard(cardTitle: 'Diagnosis'),
                SizedBox(height: 2,),
                Text("OR", style: TextStyle(
                  fontFamily: 'Poppins-SemiBold',
                  fontSize: 18.0,
                  color: Color(0xFF959595),
                ),
                ),
                SizedBox(height: 2,),
                TreatmentCard(cardTitle: 'Prognosis'),
                SizedBox(height: 25,)
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
