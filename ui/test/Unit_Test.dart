import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/screens/diagnosis/lungDiagnosis_screen.dart';
import 'package:ui/screens/diagnosis/skinDiagnosis_screen.dart';
import 'package:ui/screens/prognosis/prognosis_screen.dart';
import 'package:ui/constants.dart';

/// COMMENT OUT FIREBASE STUFF FOR TESTING PURPOSES

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

  test("Testing lung cancer prognosis ", () async {

    // ACTUAL
    CancerPrognosisState cancerPrognosisState = new CancerPrognosisState("Lung Cancer",LUNG_CANCER_PROGNOSIS_QUESTIONS,
    "https://onco-prognosis-backend.herokuapp.com/prognosis_lung");
    cancerPrognosisState.prognosisBody = {
      "Age": 44,
      "Gender": 1,
      "AirPollution": 5.5,
      "Alcoholuse": 5.5,
      "DustAllergy": 5.5,
      "OccuPationalHazards": 5.5,
      "GeneticRisk": 5.3,
      "chronicLungDisease": 1.3,
      "BalancedDiet": 1.3,
      "Obesity": 1.3,
      "Smoking": 5.6,
      "PassiveSmoker": 1.6,
      "ChestPain": 1.6,
      "CoughingofBlood": 1.8,
      "Fatigue": 5.8,
      "WeightLoss": 1.7,
      "ShortnessofBreath": 1.7,
      "Wheezing": 5.7,
      "SwallowingDifficulty": 1.1,
      "ClubbingofFingerNails": 1.2,
      "FrequentCold": 5.9,
      "DryCough": 1.0,
      "Snoring": 5.4
    };
    actual = await cancerPrognosisState.apiRequest();

    // EXPECTED
    expected = '{"Prediction": "Medium"}\n''';

    // TEST
    expect(actual, expected);

  });
}
