
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
                CustomAppBar("arrow", context),
                Column(
                  children : [

                    Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      bottom: 8,
                    ),
                    child: Align(

                      alignment: Alignment.topLeft,
                        child: Text(
                          "Personal Manager",
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
                        bottom: 14,
                        right: 20
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Here you can manage your medications, view previous reports and save doctors appointment notes.",
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
                    child: ListView(
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          Container(
                              child: PersonalCard(cardTitle: 'Medications', cardColor1: '0xFF91C77E', cardColor2:'0xFF146314' , textColor: '0xFFFFFFFF', )),
                          Container(
                              child: PersonalCard(cardTitle: 'Reports', cardColor1: '0xFF7EC794', cardColor2:'0xFF0D886B', textColor: '0xFFFFFFFF', )),
                          Container(
                              child: PersonalCard(cardTitle: 'Appointments', cardColor1: '0xFF7EC5C7', cardColor2:'0xFF145663', textColor: '0xFFFFFFFF', ))
                        ]
                    )
                ),
              ],
            ),
          ),
    );
  }
}
