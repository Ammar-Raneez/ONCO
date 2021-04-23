import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:ui/components/alert_widget.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui/services/UserDetails.dart';
import 'package:ui/services/endPoints.dart';
import 'dart:convert';
import 'dart:io';

class CancerPrognosis extends StatefulWidget {
  var _cancerType;
  var _url;
  var _cancerPrognosisAttributes;
  var _skinCancerAnswers;

  CancerPrognosis(String cancerType) {
    this._cancerType = cancerType;

    if (cancerType == "Breast Cancer") {
      _cancerPrognosisAttributes = BREAST_CANCER_PROGNOSIS_QUESTIONS;
      _url = postBreastCancerPrediction_API;
    } else if (cancerType == "Lung Cancer") {
      _cancerPrognosisAttributes = LUNG_CANCER_PROGNOSIS_QUESTIONS;
      _url = postLungCancerPrediction_API;
    } else if (cancerType == "Skin Cancer") {
      _url = postSkinCancerPrediction_API;

      if (UserDetails.getUserData()['gender'] == "male") {
        _cancerPrognosisAttributes = SKIN_CANCER_PROGNOSIS_QUESTIONS_MALE;
        _skinCancerAnswers = SKIN_CANCER_PROGNOSIS_ANSWER_OPTIONS_MALE;
      } else if (UserDetails.getUserData()['gender'] == "female") {
        _cancerPrognosisAttributes = SKIN_CANCER_PROGNOSIS_QUESTIONS_FEMALE;
        _skinCancerAnswers = SKIN_CANCER_PROGNOSIS_ANSWER_OPTIONS_FEMALE;
      }
    }
  }

  @override
  CancerPrognosisState createState() => CancerPrognosisState(
      _cancerType, _cancerPrognosisAttributes, _skinCancerAnswers, _url);
}

class CancerPrognosisState extends State<CancerPrognosis> {
  ScrollController _controller = ScrollController();
  List<Widget> _itemsData = [];
  List<TextEditingController> _textFieldControllers = [];
  List<String> _skinCancerUserAnswers = [];
  Map prognosisBody;
  final _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _cancerType;
  var _cancerPrognosisAttributes;
  var _skinCancerAnswers;
  var _url;
  var _count = 0;

  CancerPrognosisState(var cancerType, var cancerPrognosisAttributes,
      var skinCancerAnswers, var url) {
    this._cancerType = cancerType;
    this._cancerPrognosisAttributes = cancerPrognosisAttributes;
    this._skinCancerAnswers = skinCancerAnswers;
    this._url = url;
  }

  // https://stackoverflow.com/questions/50278258/http-post-with-json-on-body-flutter-dart <- REFERENCE
  Future<String> apiRequest() async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(_url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(prognosisBody)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  void _getPostsDataSkin() {
    // for (String question in cancerPrognosisAttributes) {
    //   if (question != "Age") {
    //     skinCancerUserAnswers.add("");
    //   }
    // }

    if (UserDetails.getUserData()['gender'] == "male") {
      for (List answer in SKIN_CANCER_PROGNOSIS_ANSWER_OPTIONS_MALE) {
        _skinCancerUserAnswers.add(answer[0]);
      }
    } else {
      for (List answer in SKIN_CANCER_PROGNOSIS_ANSWER_OPTIONS_FEMALE) {
        _skinCancerUserAnswers.add(answer[0]);
      }
    }

    List<dynamic> responseList = _cancerPrognosisAttributes;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      if (_count == 0) {
        _textFieldControllers.add(new TextEditingController());
        listItems.add(Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Container(
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: EdgeInsets.only(top: 0, bottom: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Color(0xFFABD8E2),
                      ),
                      child: Column(children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              post,
                              style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                color: Colors.blueGrey,
                                fontSize: 16,
                              ),
                            )),
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some Input';
                              } else if (int.parse(value) < 26 ||
                                  int.parse(value) > 70)
                                return 'Please make sure User Input is between 25 and 70';

                              return null;
                            },
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            controller: _textFieldControllers[_count],
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(16),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(16),
                                ),
                                hintText: 'Enter the Value for the Input'),
                          ),
                        ),
                      ])),
                ))));
      } else {
        List<String> skinCancerOptions = [];

        for (int i = 0; i < _skinCancerAnswers[_count - 1].length; i++)
          skinCancerOptions.add(_skinCancerAnswers[_count - 1][i]);

        int currentQuestion = 0;
        currentQuestion = _count - 1;

        listItems.add(Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Container(
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: EdgeInsets.only(top: 0, bottom: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Color(0xFFABD8E2),
                      ),
                      child: Column(children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              post,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                color: Colors.blueGrey,
                                fontSize: 16,
                              ),
                            )),
                        Column(
                          children: <Widget>[
                            GroupButton(
                              selectedTextStyle: TextStyle(color: Colors.white),
                              selectedColor: Colors.redAccent,
                              spacing: 20,
                              onSelected: (index, isSelected) =>
                                  _skinCancerUserAnswers[currentQuestion] =
                                      _skinCancerAnswers[currentQuestion]
                                          [index],
                              buttons: List.from(skinCancerOptions),
                              selectedButtons: [],
                            )
                          ],
                        )
                      ])),
                ))));
      }
      if (_count != 7) _count++;
    });
    setState(() {
      _itemsData = listItems;
    });
  }

  void _getPostsData() {
    List<dynamic> responseList = _cancerPrognosisAttributes;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      _textFieldControllers.add(new TextEditingController());
      listItems.add(Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Container(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    margin: EdgeInsets.only(top: 0, bottom: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color(0xFFABD8E2),
                    ),
                    child: Column(children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            post,
                            style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              color: Colors.blueGrey,
                              fontSize: 20,
                            ),
                          )),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some Input';
                          }

                          return null;
                        },
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        controller: _textFieldControllers[_count],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(16),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(16),
                            ),
                            hintText: 'Enter the Value for the Input'),
                      ),
                    ])),
              ))));

      _count++;
    });
    setState(() {
      _itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();

    /* If Cancer Type is Skin then a Separate Post Data Method for the Construction of the ListView
     * due to the fact that Skin Cancer uses Grouped Buttons
     */
    if (_cancerType == "Skin Cancer")
      _getPostsDataSkin();
    else
      _getPostsData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar.arrow(context),
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      _cancerType,
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 27,
                        color: Color(0xFF93ACB1),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.help),
                    onPressed: () {
                      // Setting the Help Message on the Alert Dialog based on the Cancer Type
                      String helpMessage;

                      if (_cancerType == "Breast Cancer")
                        helpMessage =
                            "Fine needle aspiration is a type of biopsy "
                            "procedure. In fine needle aspiration, a thin needle "
                            "is inserted into an area of abnormal-appearing tissue or body fluid";
                      else if (_cancerType == "Lung Cancer")
                        helpMessage =
                            "You need to enter values based on your own scale for all these inputs "
                            "based on how much you think this factor is involved in your life. i.e for Alcohol Use "
                            "you but a Higher number if you think you consume or are exposed to large amounts of alcohol";
                      else if (_cancerType == "Skin Cancer")
                        helpMessage =
                            "Simply Toggle a Button for each Question based on your Answer to calculate"
                            " your Risk of Skin Cancer over the next 5 Years";

                      // Displaying the help alert dialog
                      createAlertDialog(context, "Help", helpMessage, 404);
                    },
                  )
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Prognosis",
                  style: TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 27.0,
                    color: Color(0xFF565D5E),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (_cancerType != "Skin Cancer")
                Expanded(
                    child: Form(
                  key: _formKey,
                  child: ListView.builder(
                      controller: _controller,
                      itemCount: _itemsData.length,
                      itemBuilder: (context, index) {
                        return _itemsData[index];
                      }),
                )),
              if (_cancerType == "Skin Cancer")
                Expanded(
                    child: ListView.builder(
                        controller: _controller,
                        itemCount: _itemsData.length,
                        itemBuilder: (context, index) {
                          return _itemsData[index];
                        })),
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
                            "Predict",
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
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        /* If Else Conditions here to take each Input from the
                         * textFieldControllers Array, and setting the Input to
                         * each Attribute required by a Model in a Dictionary
                         * the Number Controllers will match the number of Attributes
                         * required by the Model
                         */

                        int genderIndex = 0;

                        if (UserDetails.getUserData()['gender'] == "female")
                          genderIndex = 1;

                        print(genderIndex);

                        if (_cancerType == "Lung Cancer") {
                          prognosisBody = {
                            "Age": _textFieldControllers[0].text,
                            "Gender": genderIndex,
                            "AirPollution":
                                ((int.parse(_textFieldControllers[1].text) /
                                            10) *
                                        8)
                                    .toString(),
                            "Alcoholuse":
                                ((int.parse(_textFieldControllers[2].text) /
                                            10) *
                                        8)
                                    .toString(),
                            "DustAllergy":
                                ((int.parse(_textFieldControllers[3].text) /
                                            10) *
                                        8)
                                    .toString(),
                            "OccuPationalHazards":
                                ((int.parse(_textFieldControllers[4].text) /
                                            10) *
                                        8)
                                    .toString(),
                            "GeneticRisk":
                                ((int.parse(_textFieldControllers[5].text) /
                                            10) *
                                        7)
                                    .toString(),
                            "chronicLungDisease":
                                ((int.parse(_textFieldControllers[6].text) /
                                            10) *
                                        7)
                                    .toString(),
                            "BalancedDiet":
                                ((int.parse(_textFieldControllers[7].text) /
                                            10) *
                                        7)
                                    .toString(),
                            "Obesity":
                                ((int.parse(_textFieldControllers[8].text) /
                                            10) *
                                        7)
                                    .toString(),
                            "Smoking":
                                ((int.parse(_textFieldControllers[9].text) /
                                            10) *
                                        8)
                                    .toString(),
                            "PassiveSmoker":
                                ((int.parse(_textFieldControllers[10].text) /
                                            10) *
                                        8)
                                    .toString(),
                            "ChestPain":
                                ((int.parse(_textFieldControllers[11].text) /
                                            10) *
                                        9)
                                    .toString(),
                            "CoughingofBlood":
                                ((int.parse(_textFieldControllers[12].text) /
                                            10) *
                                        9)
                                    .toString(),
                            "Fatigue":
                                ((int.parse(_textFieldControllers[13].text) /
                                            10) *
                                        9)
                                    .toString(),
                            "WeightLoss":
                                ((int.parse(_textFieldControllers[14].text) /
                                            10) *
                                        8)
                                    .toString(),
                            "ShortnessofBreath":
                                ((int.parse(_textFieldControllers[15].text) /
                                            10) *
                                        9)
                                    .toString(),
                            "Wheezing":
                                ((int.parse(_textFieldControllers[16].text) /
                                            10) *
                                        8)
                                    .toString(),
                            "SwallowingDifficulty":
                                ((int.parse(_textFieldControllers[17].text) /
                                            10) *
                                        8)
                                    .toString(),
                            "ClubbingofFingerNails":
                                ((int.parse(_textFieldControllers[18].text) /
                                            10) *
                                        9)
                                    .toString(),
                            "FrequentCold":
                                ((int.parse(_textFieldControllers[19].text) /
                                            10) *
                                        7)
                                    .toString(),
                            "DryCough":
                                ((int.parse(_textFieldControllers[20].text) /
                                            10) *
                                        7)
                                    .toString(),
                            "Snoring":
                                ((int.parse(_textFieldControllers[21].text) /
                                            10) *
                                        7)
                                    .toString(),
                          };
                        } else if (_cancerType == "Breast Cancer") {
                          prognosisBody = {
                            "radius_mean": _textFieldControllers[0].text,
                            "texture_mean": _textFieldControllers[1].text,
                            "perimeter_mean": _textFieldControllers[2].text,
                            "compactness_mean": _textFieldControllers[3].text,
                            "concavity_mean": _textFieldControllers[4].text,
                            "concave points_mean":
                                _textFieldControllers[5].text,
                            "fractal_dimension_mean":
                                _textFieldControllers[6].text,
                            "radius_se": _textFieldControllers[7].text,
                            "texture_se": _textFieldControllers[8].text,
                            "perimeter_se": _textFieldControllers[9].text,
                            "compactness_se": _textFieldControllers[10].text,
                            "concavity_se": _textFieldControllers[11].text,
                            "concave points_se": _textFieldControllers[12].text,
                            "symmetry_se": _textFieldControllers[13].text,
                            "fractal_dimension_se":
                                _textFieldControllers[14].text,
                            "compactness_worst": _textFieldControllers[15].text,
                            "concavity_worst": _textFieldControllers[16].text,
                            "concave points_worst":
                                _textFieldControllers[17].text,
                            "symmetry_worst": _textFieldControllers[18].text,
                            "fractal_dimension_worst":
                                _textFieldControllers[19].text,
                            "tumor_size": _textFieldControllers[20].text,
                            "positive_axillary_lymph_node":
                                _textFieldControllers[21].text
                          };
                        } else if (_cancerType == "Skin Cancer") {
                          List<int> skinCancerUserAnswersIndices = [];

                          int questionCount = 0;
                          int answerInQuestionCount;
                          for (String userAnswer in _skinCancerUserAnswers) {
                            answerInQuestionCount = 0;
                            if (userAnswer == "") {
                              skinCancerUserAnswersIndices.add(0);
                              continue;
                            }
                            for (String answer
                                in _skinCancerAnswers[questionCount]) {
                              if (userAnswer == answer) {
                                skinCancerUserAnswersIndices
                                    .add(answerInQuestionCount);
                                break;
                              }
                              answerInQuestionCount++;
                            }
                            questionCount++;
                          }

                          print(skinCancerUserAnswersIndices);

                          if (UserDetails.getUserData()['gender'] == "male")
                            prognosisBody = {
                              "age": _textFieldControllers[0].text,
                              "gender": "male",
                              "sunburn": skinCancerUserAnswersIndices[1],
                              "complexion": skinCancerUserAnswersIndices[0],
                              "big-moles": skinCancerUserAnswersIndices[2],
                              "small-moles": skinCancerUserAnswersIndices[3],
                              "freckling": skinCancerUserAnswersIndices[4],
                              "damage": skinCancerUserAnswersIndices[5],
                              "tan": 0
                            };
                          else if (UserDetails.getUserData()['gender'] ==
                              "female")
                            prognosisBody = {
                              "age": _textFieldControllers[0].text,
                              "gender": "female",
                              "sunburn": 0,
                              "complexion": skinCancerUserAnswersIndices[0],
                              "big-moles": 0,
                              "small-moles": skinCancerUserAnswersIndices[2],
                              "freckling": skinCancerUserAnswersIndices[3],
                              "damage": 0,
                              "tan": skinCancerUserAnswersIndices[1]
                            };
                        }

                        print(prognosisBody);

                        // Progress Dialog that will run till API Request is received
                        final ProgressDialog progressDialog = ProgressDialog(
                            context,
                            type: ProgressDialogType.Normal,
                            isDismissible: false,
                            showLogs: true);

                        // Styling Progress Dialog
                        progressDialog.style(
                            message: '   Analyzing\n   Input',
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

                        // Showing the Progress Dialog and Dismissing it After the API Request is Received
                        progressDialog.show();

                        String reply = await apiRequest();

                        progressDialog.hide();

                        print(reply);

                        // checking if the response is not null and displaying the result
                        if (reply != null) {
                          final body = json.decode(reply);

                          var prognosisResult;

                          if (body["message"] == "Internal Server Error")

                            // Displaying the alert dialog if Internal Server Error
                            createAlertDialog(
                                context,
                                "Error",
                                "Something's wrong on our end :( please try again !",
                                404);
                          else {
                            if (_cancerType != "Skin Cancer")
                              prognosisResult = body["Prediction"];
                            else {
                              prognosisResult = body['result_string'];
                            }

                            /* For Breast Cancer Prognosis the Result is either 'R'
                             * for Recurring and 'N' for Non-Recurring, so an If Condition
                             * is used to set the Result to a more User Friendly
                             * message
                             */
                            if (prognosisResult == "N" &&
                                _cancerType == "Breast Cancer")
                              prognosisResult = "Non-Recurring";
                            else if (prognosisResult == "R" &&
                                _cancerType == "Breast Cancer")
                              prognosisResult = "Recurring";

                            // Displaying the alert dialog
                            createAlertDialog(
                                context, "Prognosis", prognosisResult, 203);

                            // Adding the response data into the database for report creation purpose
                            // initially, convert all inputs into strings for the report
                            Map firebasePrognosisBody;
                            setState(() {
                              firebasePrognosisBody = prognosisBody;

                              for (var eachItem in firebasePrognosisBody.keys) {
                                firebasePrognosisBody[eachItem] =
                                    firebasePrognosisBody[eachItem].toString();
                              }
                            });

                            _firestore
                                .collection("users")
                                .doc(UserDetails.getUserData()["email"])
                                .collection("InputPrognosis")
                                .add({
                              "prognosisInputs": firebasePrognosisBody,
                              "cancerType": _cancerType,
                              "reportType": "prognosis",
                              "result": prognosisResult,
                              'timestamp': Timestamp.now(),
                            });
                          }
                        } else {
                          // Displaying the alert dialog
                          createAlertDialog(context, "Error",
                              "Oops something went wrong!", 404);
                        }
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
