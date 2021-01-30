import 'dart:ui';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/RoundedButton.dart';
import 'package:ui/constants.dart';

class LungCancerDiagnosis extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "lungCancerDiagnosisScreen";

  @override
  _LungCancerDiagnosisState createState() => _LungCancerDiagnosisState();
}

class _LungCancerDiagnosisState extends State<LungCancerDiagnosis> {
  File imageFile;

  // open Gallery method
  _openGallery() async {
    var selectedPicture =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = selectedPicture;
    });
  }

  // open camera method
  _openCamera() async {
    var selectedPicture =
        await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = selectedPicture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff01CDFA),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // HEADER WITH ONCO LOGO AND ICON BUTTON
              Expanded(
                child: Material(
                  color: Color(0xff01CDFA),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // navigate back
                          },
                        ),
                        Image.asset(
                          'images/officialLogo.png',
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // THE REST OF THE BODY CONTENT OF THE SCREEN
              Expanded(
                flex: 6,
                child: Material(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70.0),
                  ),
                  color: Colors.white,

                  // PADDING WIDGET
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // LUNG CANCER DIAGNOSIS TEXT CONTENT
                        Text(
                          "Lung Cancer",
                          style: kTextStyle.copyWith(
                            color: Colors.blueGrey,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          "Diagnosis",
                          style: kTextStyle.copyWith(
                            color: Colors.black54,
                            fontSize: 25,
                          ),
                        ),
                        // DISPLAY THE UPLOADED IMAGE OR CAPTURED IMAGE BY THE USER
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: imageFile == null
                                ? Image.asset('images/uploadImageGrey1.png')
                                : Image.file(
                                    imageFile,
                                    width: 500,
                                    height: 500,
                                  ),
                          ),
                        ),

                        // CAPTURE(FROM CAMERA) AND UPLOAD(FROM GALLERY) BUTTON
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(
                              elevation: 3.0,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 10.0),
                              color: Colors.lightBlueAccent,
                              onPressed: () {
                                // open the camera to capture image
                                _openCamera();
                              },
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            RaisedButton(
                              elevation: 3.0,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 10.0),
                              color: Colors.lightBlueAccent,
                              onPressed: () {
                                // open gallery to select image
                                _openGallery();
                              },
                              child: Icon(
                                Icons.photo,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // DETECTION BUTTON
                        RoundedButton(
                          onPressed: () {
                            //Implement lung cancer detect functionality.
                          },
                          colour: Colors.redAccent,
                          title: 'DETECT',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
