import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/screens/diagnosis/lungDiagnosis_screen.dart';
import 'package:ui/screens/diagnosis/skinDiagnosis_screen.dart';

// Comment out firebase stuff for testing purposes

void main() {
  String actual;
  String expected;

  test("Testing lung cancer diagnosis (Healthy lung)", () async {

    // ACTUAL
    LungCancerDiagnosisState lungCancerDiagnosisState =
        new LungCancerDiagnosisState();
    FormData formData = new FormData.fromMap({
      "file": await MultipartFile.fromFile(
          "images/healthy-lung-test.jpeg",
          filename: "testingImage"),
    });

    await lungCancerDiagnosisState.getResponse(formData);
    actual = lungCancerDiagnosisState.responseBody['predition'];

    // EXPECTED
    expected = "NORMAL";

    // TEST
    expect(actual, expected);

  });

  test("Testing lung cancer diagnosis (Infected lung)", () async {

    // ACTUAL
    LungCancerDiagnosisState lungCancerDiagnosisState =
    new LungCancerDiagnosisState();
    FormData formData = new FormData.fromMap({
      "file": await MultipartFile.fromFile(
          "images/infected-lung-test.png",
          filename: "testingImage"),
    });

    await lungCancerDiagnosisState.getResponse(formData);
    actual = lungCancerDiagnosisState.responseBody['predition'];

    // EXPECTED
    expected = "CANCER";

    // TEST
    expect(actual, expected);

  });

  test("Testing skin cancer diagnosis", () async {

    // ACTUAL
    SkinCancerDiagnosisState skinCancerDiagnosisState =
    new SkinCancerDiagnosisState();
    FormData formData = new FormData.fromMap({
      "file": await MultipartFile.fromFile(
          "images/skin-infected-test.jpg",
          filename: "testingImage"),
    });

    await skinCancerDiagnosisState.getResponse(formData);
    actual = skinCancerDiagnosisState.responseBody['status'].toString();

    // EXPECTED
    expected = "200";

    // TEST
    expect(actual, expected);

  });
}
