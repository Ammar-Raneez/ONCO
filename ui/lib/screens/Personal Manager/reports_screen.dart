import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/components/reports_card.dart';
import 'package:ui/screens/Personal%20Manager/viewReport_screen.dart';

class ReportManager extends StatefulWidget {
  @override
  _ReportManagerState createState() => _ReportManagerState();
}

class _ReportManagerState extends State<ReportManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.arrow(context),
      body: SafeArea(
        child: Container(
          child:Column(
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
                            "Reports",
                            style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 32,
                              color: Color(0xFF00404E)
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom:15
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Here you can manage your medications, click add a medication to create one and drag the medication to delete it",
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
                ],
              ),
              GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewReport() // Navigates to Task Page
                      ),
                    ).then((value){
                      setState(() {}); // Setting and Refreshing State
                    });
                  },
                  child: ReportCard(reportDate: "28th April 2021", reportType: "Lung Cancer Prognosis")
              ),
              ReportCard(reportDate: "24th April 2021", reportType: "Breast Cancer Prognosis"),
              ReportCard(reportDate: "5th April 2021", reportType: "Lung Cancer Diagnosis"),

            ],
          )
        ),
      ),
    );
  }
}
