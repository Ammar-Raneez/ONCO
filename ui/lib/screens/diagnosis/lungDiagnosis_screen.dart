import 'dart:ui';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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
  //  Variables
  File imageFile;
  Dio dio = new Dio();

  // open Gallery method
  _openGallery() async {
    var selectedPicture =
        await ImagePicker.pickImage(source: ImageSource.gallery);

    // NOTE that selectedPicture may also contain null value, suppose user opens gallery and exits
    // without selecting a picture.
    setState(() {
      imageFile = selectedPicture;
    });
  }

  // detect the cancer
  _detect() async {
    try {
      String fileName = imageFile.path.split('/').last;
      print(fileName);

      FormData formData = new FormData.fromMap({
        "file":  await MultipartFile.fromFile(imageFile.path, filename:fileName),
      });
      print(formData);

      Response response = await dio.post(
        "http://192.168.1.3/predict",
        data: formData,
      );
      print(response);
    } catch (e) {
      print("Exception Caught: $e");
    }
  }


  // open camera method
  _openCamera() async {
    var selectedPicture =
        await ImagePicker.pickImage(source: ImageSource.camera);

    // NOTE that selectedPicture may also contain null value, suppose user opens the camera and exits
    // without capturing a picture.
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
                            _detect();
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

// IMPORTANT REFERENCE USED TO CONNECT FLUTTER AND FLASK FOR (MOBILE PHONE)
// https://medium.com/@podcoder/connecting-flutter-application-to-localhost-a1022df63130
// MAKE SURE THE python script is running on this:
// app.run(host="0.0.0.0", port=80)
// 192.168.1.3 <--- this is the ip address in my machine
// to get your ip address go to cmd and hit ipconfig to get ur LAN ip