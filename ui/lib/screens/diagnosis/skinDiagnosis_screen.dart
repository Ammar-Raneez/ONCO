import 'dart:ui';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/alert_widget.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/components/rounded_button.dart';
import 'package:ui/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SkinCancerDiagnosis extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "skinCancerDiagnosisScreen";

  @override
  _SkinCancerDiagnosisState createState() => _SkinCancerDiagnosisState();
}

class _SkinCancerDiagnosisState extends State<SkinCancerDiagnosis> {
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
        // ignore: deprecated_member_use
        await ImagePicker.pickImage(source: ImageSource.gallery);

    // NOTE that selectedPicture may also contain null value, suppose user opens gallery and exits
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
          "http://192.168.8.100/skin-diagnosis",
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
          createAlertDialog(
              context, "Diagnosis", response.toString(), 201);
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
      child: Scaffold(
        appBar: CustomAppBar("arrow", context),
        body: ModalProgressHUD(
          // displaying the spinner for async tasks
          inAsyncCall: showSpinner,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                            "Skin Cancer",
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
                                  // OPEN THE CAMERA TO CAPTURE IMAGE
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
                                  // OPEN GALLERY TO SELECT AN IMAGE
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
                              // IMPLEMENT THE DETECT LUNG CANCER FUNCTIONALITY
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
      ),
    );
  }
}
