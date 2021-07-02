import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui/screens/Personal%20Manager/reportManager/viewReport_screen.dart';

// all report cards
class ReportCard extends StatelessWidget {
  final String cancerType;
  final String inputImageUrl;
  final String imageUrl;
  final String result;
  final String resultString;
  final String percentage;
  final String reportType;
  final Timestamp reportDate;
  final Map prognosisInputs;

  ReportCard(
      {this.cancerType,
      this.inputImageUrl,
      this.imageUrl,
      this.result,
      this.resultString,
      this.percentage,
      this.reportType,
      this.reportDate,
      this.prognosisInputs});

  @override
  Widget build(BuildContext context) {
    var timestamp;
    var formattedDate = "";
    timestamp = reportDate;
    var date =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    formattedDate = DateFormat.yMMMd().format(date); // Apr 8, 2020

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewReport(
            context,
              this.cancerType,
              this.inputImageUrl,
              this.imageUrl,
              this.result,
              this.resultString,
              this.percentage,
              this.reportType,
              this.reportDate,
              this.prognosisInputs
          ), // Navigates to Task Page
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 9),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xFF034D5D),
          ),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontFamily: 'Poppins-SemiBold',
                          fontSize: 17,
                          color: Color(0xFFECECEC),
                        ),
                      ),
                      Text(
                        cancerType.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins-SemiBold',
                          fontSize: 13,
                          color: Color(0xFFA6D6F7),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      "View",
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 17,
                        color: Color(0xFFA6D6F7),
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
