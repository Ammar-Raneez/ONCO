import 'dart:ui';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/alert_widget.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ui/services/UserDetails.dart';
import 'package:ui/services/endPoints.dart';

class LungCancerDiagnosis extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "lungCancerDiagnosisScreen";

  @override
  LungCancerDiagnosisState createState() => LungCancerDiagnosisState();
}

class LungCancerDiagnosisState extends State<LungCancerDiagnosis> {
  //  VARIABLES
  File imageFile;
  Dio dio = new Dio();
  bool showSpinner = false;
  bool showHighlightedImage = false;
  dynamic responseBody;
  final _firestore = FirebaseFirestore.instance;

  // OPEN GALLERY TO SELECT AN IMAGE METHOD (ASYNC TASK)
  _openGallery() async {
    var selectedPicture =
        // ignore: deprecated_member_use
        await ImagePicker.pickImage(source: ImageSource.gallery);

    // NOTE that 'selectedPicture' may also contain 'null' value, suppose user opens gallery and exits
    // without selecting a picture.
    setState(() {
      imageFile = selectedPicture;
      showHighlightedImage = false;
    });
  }

  // DETECT THE CANCER METHOD (ASYNC TASK)
  _detect(ProgressDialog progressDialog) async {
    // If the user selects an image only we perform the API request else an alert will be displayed
    if (imageFile == null) {
      // ALERT USER TO SELECT OR CAPTURE IMAGE FIRST OFF
      createAlertDialog(
          context, "Error", "There is no image selected or captured!", 404);
    } else {
      progressDialog.show();
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
        await getResponse(formData);

        // RESPONSE RESULT FROM THE BACKEND
        // responseBody = response.data[0];
        String resultPrediction = responseBody['predition'];
        String inputImageURL = responseBody['regular_image_url'];
        String resultImageURL = responseBody['superimposed_image_url'];
        String resultPercentage = responseBody['prediction_percentage'];

        // Adding the response data into the database for report creation purpose
        _firestore
            .collection("users")
            .doc(UserDetails.getUserData()["email"])
            .collection("imageDetections")
            .add({
          "cancerType": "lung cancer",
          "reportType": "diagnosis",
          "result": resultPrediction,
          "result_string": "$resultPrediction was detected",
          "inputImageUrl": inputImageURL,
          "imageUrl": resultImageURL,
          "percentage": resultPercentage,
          'timestamp': Timestamp.now(),
        });

        progressDialog.hide();
        // Display the spinner to indicate that its loading
        setState(() {
          showHighlightedImage = true;
        });

        // checking if the response is not null and displaying the result
        if (responseBody != null) {
          // Displaying the alert dialog
          createAlertDialog(context, "Diagnosis",
              "Detection result: " + resultPrediction, 201);
        } else {
          // Displaying the alert dialog
          createAlertDialog(
              context, "Error", "Oops something went wrong!", 404);
        }
      } catch (e) {
        // Displaying alert to the user
        createAlertDialog(context, "Error", e._message, 404);

        progressDialog.hide();
      }
    }
  }

  // Getting the detection response
  getResponse(FormData formData) async {
    Response response = await dio.post(
      postLungCancerDetection_API,
      data: formData,
    );
    responseBody = response.data[0];
    print(responseBody);
  }

  // OPEN CAMERA METHOD TO CAPTURE IMAGE FOR DETECTION PURPOSE (ASYNC TASK)
  _openCamera() async {
    setState(() {
      showSpinner = true;
    });

    var selectedPicture =
        await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imageFile = selectedPicture;
      showHighlightedImage = false;
    });

    // This delay is for building the image when clicked from camera cuz it takes some time to build
    Future.delayed(const Duration(milliseconds: 5000), () {
      // NOTE that selectedPicture may also contain null value, suppose user opens the camera and exits
      // without capturing a picture.
      setState(() {
        showSpinner = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Progress Dialog that will run till API Request is received
    final ProgressDialog progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);

    // Styling Progress Dialog
    progressDialog.style(
        message: '   Scanning\n   Image',
        padding: EdgeInsets.all(20),
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: LinearProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInCubic,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
          color: Color(0xFF565D5E),
          fontSize: 13.0,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins-SemiBold',
        ),
        messageTextStyle: TextStyle(
          color: Color(0xFF565D5E),
          fontSize: 19.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins-SemiBold',
        ));

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
                        // LUNG CANCER DIAGNOSIS TEXT CONTENT
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Lung Cancer",
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
                          child: showHighlightedImage == false
                              ? Padding(
                                  padding: const EdgeInsets.all(22),
                                  child: imageFile == null
                                      ? Image.asset(
                                          'images/uploadImageGrey1.png',
                                          scale: 13,
                                        )
                                      : Image.file(
                                          imageFile,
                                          width: 500,
                                          height: 500,
                                        ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'images/loading.gif',
                                    image: responseBody["regular_image_url"],
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
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
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
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
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
                                    "SCAN IMAGE",
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
                              _detect(progressDialog);
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

// IMPORTANT REFERENCE USED TO CONNECT FLUTTER AND FLASK FOR (MOBILE PHONE)
// https://medium.com/@podcoder/connecting-flutter-application-to-localhost-a1022df63130
// MAKE SURE THE python script is running on this:
// app.run(host="0.0.0.0", port=80)
// 192.168.1.4 <--- this is the ip address in my machine
// to get your ip address go to cmd and hit ipconfig to get ur LAN ip
// Remember to connect to the same Wifi else ip will a problem
// (NOTE: Nazhim 192.168.1.4 this was the ip for ur SLT wifi)
