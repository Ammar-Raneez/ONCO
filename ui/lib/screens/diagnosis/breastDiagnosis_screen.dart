import 'dart:ui';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/alert_widget.dart';
import 'package:ui/components/rounded_button.dart';
import 'package:ui/constants.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BreastCancerDiagnosis extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "breastCancerDiagnosisScreen";

  @override
  _BreastCancerDiagnosisState createState() => _BreastCancerDiagnosisState();
}

class _BreastCancerDiagnosisState extends State<BreastCancerDiagnosis> {
  //  VARIABLES
  File imageFile;
  Dio dio = new Dio();
  bool showSpinner = false;

  // CREATING AN ALERT
  createAlertDialog(
      BuildContext context, String title, String message, int status) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertWidget(
          title: title,
          message: message,
          status: status,
        );
      },
    );
  }

  // OPEN GALLERY TO SELECT AN IMAGE METHOD (ASYNC TASK)
  _openGallery() async {
    var selectedPicture =
        await ImagePicker.pickImage(source: ImageSource.gallery);

    // NOTE that 'selectedPicture' may also contain 'null' value, suppose user opens gallery and exits
    // without selecting a picture.
    setState(() {
      imageFile = selectedPicture;
    });
  }

  // DETECT THE CANCER METHOD (ASYNC TASK)
  _detect() async {
    // If the user selects an image only we perform the API request else an alert will be displayed
    if (imageFile == null) {
      // ALERT USER TO SELECT OR CAPTURE IMAGE FIRST OFF
      createAlertDialog(
          context, "Error", "There is no image selected or captured!", 404);
    } else {
      setState(() {
        showSpinner = true;
      });
      try {
        // GETTING THE IMAGE NAME
        String fileName = imageFile.path.split('/').last;
        print(fileName);

        // CREATING THE FORM DATA TO BE SENT TO THE BACKEND
        FormData formData = new FormData.fromMap({
          "file":
              await MultipartFile.fromFile(imageFile.path, filename: fileName),
        });
        print(formData);

        // CREATING THE RESPONSE OBJECT TO GET THE RESULT FROM THE SERVER
        Response response = await dio.post(
          "http://192.168.1.3/predict",
          data: formData,
        );
        print(response);

        // Display the spinner to indicate that its loading
        setState(() {
          showSpinner = false;
        });

        // checking if the response is not null and displaying the result
        if (response != null) {
          // Displaying the alert dialog
          createAlertDialog(context, "Diagnosis", response.toString(), 201);
        } else {
          // Displaying the alert dialog
          createAlertDialog(
              context, "Error", "Oops something went wrong!", 404);
        }
      } catch (e) {
        // Displaying alert to the user
        createAlertDialog(context, "Error", e.message, 404);

        setState(() {
          showSpinner = false;
        });
      }
    }
  }

  // OPEN CAMERA METHOD TO CAPTURE IMAGE FOR DETECTION PURPOSE (ASYNC TASK)
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
      child: ModalProgressHUD(
        // displaying the spinner for async tasks
        inAsyncCall: showSpinner,
        child: Scaffold(
          appBar: CustomAppBar.arrow(context),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // HEADER WITH ONCO LOGO AND ICON BUTTON
                // THE REST OF THE BODY CONTENT OF THE SCREEN
                Expanded(
                  flex: 6,
                  child: Material(
                    // PADDING WIDGET
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // LUNG CANCER DIAGNOSIS TEXT CONTENT
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Breast Cancer",
                            style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 27.0,
                              color: Color(0xFF93ACB1),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Diagnosis",
                            style:TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 27.0,
                              color: Color(0xFF565D5E),
                            ),
                          ),
                        ),
                        // DISPLAY THE UPLOADED IMAGE OR CAPTURED IMAGE BY THE USER
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: imageFile == null
                                ? Image.asset('images/uploadImageGrey1.png', scale: 15,)
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
                            GestureDetector(
                              onTap:(){
                                _openCamera();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.lightBlueAccent,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 15
                                ),

                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            GestureDetector(
                              onTap:(){
                                _openGallery();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.lightBlueAccent,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 15
                                ),

                                child: Icon(
                                  Icons.photo,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // DETECTION BUTTON
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0)),
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 50, right: 50),
                          child: RawMaterialButton(
                            fillColor: Colors.black54,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  SizedBox(
                                    width: 10.0,
                                    height: 30.0,
                                  ),
                                  Text(
                                    "Scan Image",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Regular',
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            shape: const StadiumBorder(),
                            onPressed: () {_detect();},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
