import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/components/reports_card.dart';
import 'package:ui/screens/Personal%20Manager/reportManager/diagnosis_reports_screen.dart';
import 'package:ui/screens/Personal%20Manager/reportManager/prognosis_reports_screen.dart';
import 'package:ui/screens/Personal%20Manager/reportManager/report_widgets/ReportListWidget.dart';

import 'api/ReportFirebaseApi.dart';
import 'api/ReportProvider.dart';
import 'models/report.dart';
import 'viewReport_screen.dart';

class ReportManager extends StatefulWidget {
  @override
  _ReportManagerState createState() => _ReportManagerState();
}

class _ReportManagerState extends State<ReportManager> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar.arrow(context),
        body: SafeArea(
          child: Container(
            child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=> DiagnosisReports()
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [Color(0xFFC6E7EE), Color(0xFF637477)],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                      ),
                      padding: EdgeInsets.only(top: 20, left: 25),
                      width: (MediaQuery.of(context).size.width),
                      height: 150,
                      child: Text(
                        "Diagnosis \nReports",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF63888F),
                          fontFamily: 'Poppins-SemiBold',
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    vertical: 20
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=> PrognosisReports()
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [Color(0xFFC6E7EE), Color(0xFF637477)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      padding: EdgeInsets.only(top: 20, left: 25),
                      width: (MediaQuery.of(context).size.width),
                      height: 150,
                      child: Text(
                        "Prognosis \nReports",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF63888F),
                          fontFamily: 'Poppins-SemiBold',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}