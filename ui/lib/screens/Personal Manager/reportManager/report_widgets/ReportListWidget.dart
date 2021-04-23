import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/reports_card.dart';
import 'package:ui/screens/Personal%20Manager/reportManager/api/ReportProvider.dart';

class ReportListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReportProvider>(context);
    final reports = provider.reports;
    reports.sort((a, b) => b.reportDate.compareTo(a.reportDate));

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
              print(report.reportDate);
              return ReportCard(report: report);
            },
          );
  }
}
