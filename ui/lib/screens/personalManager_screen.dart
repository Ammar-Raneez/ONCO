
import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/components/personal_manager_card.dart';

class PersonalManager extends StatefulWidget {
  @override
  _PersonalManagerState createState() => _PersonalManagerState();
}

class _PersonalManagerState extends State<PersonalManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
              children: [
                CustomAppBar("arrow"),
                Align(
                  alignment: Alignment.topLeft,
                    child: Text(
                      "Personal Manager",
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 20.0,
                      ),
                    ),

                ),
                Expanded(
                    child: ListView(
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          Container(
                              child: PersonalCard(cardTitle: 'Medications', cardColor: '0xFF7EB9C7', textColor: '0xFFFFFFFF', )),
                          Container(
                              child: PersonalCard(cardTitle: 'Reports', cardColor: '0xFF7EB9C7', textColor: '0xFFFFFFFF', )),
                          Container(
                              child: PersonalCard(cardTitle: 'Appointments', cardColor: '0xFF7EB9C7', textColor: '0xFFFFFFFF', ))
                        ]
                    )
                ),
              ],
            ),
          ),
    );
  }
}
