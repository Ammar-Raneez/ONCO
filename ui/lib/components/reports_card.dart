import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ui/screens/Personal%20Manager/reportManager/models/report.dart';
import 'package:intl/intl.dart';
import 'package:ui/screens/Personal%20Manager/reportManager/viewReport_screen.dart';

class ReportCard extends StatelessWidget {

  final Report report;


  ReportCard({
    @required this.report
  });

  @override
  Widget build(BuildContext context) {

    var timestamp;
    var formattedDate="";
    timestamp = report.reportDate;
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    formattedDate = DateFormat.yMMMd().format(date); // Apr 8, 2020

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ViewReport(context, report), // Navigates to Task Page
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical:5.0,
            horizontal: 9
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xFF034D5D)
          ),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20,
                      top: 20,
                      bottom: 20
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 17,
                            color: Color(0xFFECECEC)
                        ),
                      ),
                      Text(
                        report.cancerType.toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 13,
                            color: Color(0xFFA6D6F7)
                        ),
                      )
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 30
                    ),
                    child: Text("View",
                      style: TextStyle(
                          fontFamily: 'Poppins-SemiBold',
                          fontSize: 17,
                          color: Color(0xFFA6D6F7)
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

        ),
      ),
    );
  }
}
