import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/screens/diagnosis/lungDiagnosis_screen.dart';
import 'package:ui/main.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  String actual;
  String expected;

  test("Testing lung cancer diagnosis", () async {
    // Comment Out all the firebase stuff from the lungDiagnosis_screen.dart when running the test.
    // ACTUAL
    LungCancerDiagnosisState lungCancerDiagnosisState =
        new LungCancerDiagnosisState();
    FormData formData = new FormData.fromMap({
      "file": await MultipartFile.fromFile(
          "images/officialLogo.png",
          filename: "testingImage"),
    });
    print(formData);
    await lungCancerDiagnosisState.getResponse(formData);
    actual = lungCancerDiagnosisState.responseBody['predition'];

    // EXPECTED
    String expected = "CANCER";

    // TEST
    expect(actual, expected);

  });
}
