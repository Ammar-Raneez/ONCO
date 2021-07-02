import 'package:flutter/material.dart';
import 'package:ui/components/reports_card.dart';

class ReportListWidget extends StatelessWidget {
  final reports;

  ReportListWidget({this.reports});

  @override
  Widget build(BuildContext context) {
    return reports.isEmpty
        ? Center(
            child: Text(
              'No Reports Created.',
              style: TextStyle(
                color: Color(0xffaaaaaa),
                fontFamily: 'Poppins-SemiBold',
                fontSize: 17,
              ),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder: (context, index) => Container(height: 5),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];

              return ReportCard(
                  cancerType: report["cancerType"],
                  inputImageUrl: report["inputImageUrl"],
                  imageUrl: report["imageUrl"],
                  result: report["result"],
                  resultString: report["result_string"],
                  percentage: report["percentage"],
                  reportType: report["reportType"],
                  reportDate: report["timestamp"],
                  prognosisInputs: report["prognosisInputs"]);
            },
          );
  }
}
