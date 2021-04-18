import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/screens/Personal%20Manager/reportManager/api/ReportProvider.dart';
import 'package:ui/screens/Personal%20Manager/reportManager/models/report.dart';
import 'package:ui/screens/Personal%20Manager/reportManager/report_widgets/ReportListWidget.dart';

class ViewReport extends StatefulWidget {

  final Report report;
  ViewReport({@required this.report});

  @override
  _ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {

  // Variables used within file
  String _reportType;
  String _reportDate;
  String _reportPercentage;

  @override
  void initState() {
    super.initState();

    _reportType = widget.report.reportType;
    _reportDate = widget.report.reportDate.toString();
    _reportPercentage = widget.report.percentage;

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar.arrow(context),
        body: SafeArea(
          child: Container(
            child:Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 20,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _reportDate,
                          style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 27,
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
                          _reportType,
                          style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 19,
                              color: Color(0xFF3C707B)
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 15,
                    bottom: 10
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("INPUTS PROVIDED",
                      style: TextStyle(
                          fontFamily: 'Poppins-SemiBold',
                          fontSize: 18,
                          color: Color(0xFF7CC2C4)
                      ),
                    ),
                  ),
                ),

                ListView(
                  children: [

                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
