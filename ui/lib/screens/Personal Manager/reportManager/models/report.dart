import 'package:flutter/material.dart';
class Report {

  String id;
  String cancerType;
  String imageUrl;
  String result;
  String percentage;
  String reportType;
  String reportDate;

  Report({
    this.reportType = '',
    this.reportDate='',
    this.imageUrl='',
    this.percentage='',
  }); // Constructor

  static Report fromJson(Map<String, dynamic> json) => Report(
    reportType: json['reportType'],
    reportDate: json['timestamp'],
    imageUrl: json['imageUrl'],
    percentage: json['percentage'],
  );

}
