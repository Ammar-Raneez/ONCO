import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String id;
  String cancerType;
  String inputImageUrl;
  String imageUrl;
  String result;
  String resultString;
  String percentage;
  String reportType;
  Timestamp reportDate;
  Map prognosisInputs;

  Report(
      {this.reportType = '',
      this.reportDate,this.inputImageUrl = '',
      this.imageUrl = '',
      this.percentage = '',
      this.cancerType = '',
      this.result = '',
      this.resultString = '',
      this.prognosisInputs}); // Constructor

  static Report fromDiagnosisJson(Map<String, dynamic> json) => Report(
      reportType: json['reportType'],
      reportDate: json['timestamp'],
      result: json['result'],
      resultString: json['result_string'],
      cancerType: json['cancerType'],
      inputImageUrl: json['cancerType'] != "skin cancer" ? json['inputImageUrl'] : "",
      imageUrl: json['imageUrl'],
      percentage: json['percentage']);

  static Report fromPrognosisJson(Map<String, dynamic> json) => Report(
      reportType: json['reportType'],
      reportDate: json['timestamp'],
      result: json['result'],
      cancerType: json['cancerType'],
      prognosisInputs: json['prognosisInputs']);
}
