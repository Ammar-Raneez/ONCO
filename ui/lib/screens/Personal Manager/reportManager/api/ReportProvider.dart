import 'package:flutter/material.dart';
import 'package:ui/screens/Personal%20Manager/reportManager/models/report.dart';

class ReportProvider extends ChangeNotifier {
  List<Report> _reports = [];

  List<Report> get reports => _reports.toList();

  void setReports(List<Report> medications) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print(_reports);
        _reports = reports;
        notifyListeners();
      });
}
