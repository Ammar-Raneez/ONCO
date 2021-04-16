import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {

  final String reportDate;
  final String reportType;
  Re

  ReportCard({@required this.report,@required this.reportType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical:5.0,
          horizontal: 15
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
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
                      reportDate,
                      style: TextStyle(
                          fontFamily: 'Poppins-SemiBold',
                          fontSize: 17,
                          color: Color(0xFFECECEC)
                      ),
                    ),
                    Text(
                      reportType,
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
    );
  }
}
