import 'package:flutter/material.dart';

// This constant is for the login background gradient color
const kBackgroundBlueGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xff01CDFA), Colors.white],
);

// This constant is for the text field decoration
const kTextFieldDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  hintText: '',
//  prefixIcon: Icon(Icons.done),
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff01CDFA), width: 1.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff01CDFA), width: 2.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
);

// This constant is for the Text style for the
const kTextStyle = TextStyle(
  color: Colors.black38,
  fontSize: 15,
  fontWeight: FontWeight.bold,
  fontFamily: 'Poppins-Regular',
);

const SKIN_CANCER_PROGNOSIS_QUESTIONS =
[

];

const LUNG_CANCER_PROGNOSIS_QUESTIONS =
[
  "Age",
  "Gender",
  "Air Pollution",
  "Alcohol use",
  "Dust Allergy",
  "Occupational Hazards",
  "Genetic Risk",
  "Chronic Lung Disease",
  "Balanced Diet",
  "Obesity",
  "Smoking",
  "Passive Smoker",
  "Chest Pain",
  "Coughing of Blood",
  "Fatigue",
  "Weight Loss",
  'Shortness of Breath',
  "Wheezing",
  "Swallowing Difficulty",
  "Clubbing of Finger Nails",
  "Frequent Cold",
  "Dry Cough",
  "Snoring",
];

const BREAST_CANCER_PROGNOSIS_QUESTIONS =
[
  "Radius Mean",
  "Radius SE",
  "Texture Mean",
  "Texture SE",
  "Perimeter Mean",
  "Perimeter_se",
  "Compactness Mean",
  "Compactness SE",
  "Compactness Worst",
  "Concavity Mean",
  "Concavity SE",
  "Concavity Worst",
  "Points Mean",
  "Points Worst",
  "Concave",
  "Concave Points SE",
  "Fractal Dimension Mean",
  "Fractal Dimension SE",
  "Fractal Dimension Worst",
  "Symmetry SE",
  "Symmetry Worst",
  "Tumor Size",
  "Positive Axillary Lymph Node"
];