import 'dart:ui';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/alert_widget.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ui/services/UserDetails.dart';

class SkinCancerDiagnosis extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "skinCancerDiagnosisScreen";

  @override
  SkinCancerDiagnosisState createState() => SkinCancerDiagnosisState();
}

class SkinCancerDiagnosisState extends State<SkinCancerDiagnosis> {
  //  VARIABLES
  File imageFile;
  Dio dio = new Dio();
  bool showSpinner = false;
  dynamic responseBody;
  // final _firestore = FirebaseFirestore.instance;

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

        // CREATING THE RESPONSE OBJECT TO GET THE RESULT FROM THE SERVER
        await getResponse(formData);

        String resultDetection = responseBody['result_string'];
        String imageDownloadURL = responseBody['imageDownloadURL'];

        // Adding the response data into the database for report creation purpose
        // _firestore
        //     .collection("users")
        //     .doc(UserDetails.getUserData()["email"])
        //     .collection("imageDetections")
        //     .add({
        //             "cancerType": "skin",
        //             "reportType": "diagnosis",
        //             "result": resultDetection,
        //             "imageUrl": imageDownloadURL,
        //             'timestamp': Timestamp.now(),
        //           });

        // Display the spinner to indicate that its loading
        setState(() {
          showSpinner = false;
        });

        // checking if the response is not null and displaying the result
        if (responseBody != null) {
          // Displaying the alert dialog
          createAlertDialog(context, "Diagnosis", resultDetection, 201);
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

  // Getting the detection response
  getResponse(FormData formData) async {
    Response response = await dio.post(
      "https://skinmodelsdgp.azurewebsites.net/api/skinmodelsdgp?model=skin",
      data: formData,
    );
    // RESPONSE DATA FROM THE BACKEND
    responseBody = response.data[0];
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
                // THE REST OF THE BODY CONTENT OF THE SCREEN
                Expanded(
                  flex: 6,
                  child: Material(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //SKIN CANCER DIAGNOSIS TEXT CONTENT
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Skin Cancer",
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
                            style: TextStyle(
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
                                ? Image.asset(
                                    'images/uploadImageGrey1.png',
                                    scale: 15,
                                  )
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
                              onTap: () {
                                _openCamera();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.lightBlueAccent,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
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
                              onTap: () {
                                _openGallery();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.lightBlueAccent,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
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
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 50, right: 50),
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
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            shape: const StadiumBorder(),
                            onPressed: () {
                              _detect();
                            },
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
