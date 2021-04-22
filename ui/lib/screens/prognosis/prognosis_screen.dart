import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:ui/components/alert_widget.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui/services/UserDetails.dart';
import 'dart:convert';
import 'dart:io';

class CancerPrognosis extends StatefulWidget {
  var cancerType;
  var url = "https://onco-prognosis-backend.herokuapp.com/";
  var cancerPrognosisAttributes;
  var skinCancerAnswers;

  CancerPrognosis(String cancerType) {
    this.cancerType = cancerType;

    if (cancerType == "Breast Cancer") {
      cancerPrognosisAttributes = BREAST_CANCER_PROGNOSIS_QUESTIONS;
      url += "prognosis_breast";
    } else if (cancerType == "Lung Cancer") {
      cancerPrognosisAttributes = LUNG_CANCER_PROGNOSIS_QUESTIONS;
      url += "prognosis_lung";
    } else if (cancerType == "Skin Cancer") {

      url += "prognosis_skin";

      if (UserDetails.getUserData()['gender'] == "male") {

        cancerPrognosisAttributes = SKIN_CANCER_PROGNOSIS_QUESTIONS_MALE;
        skinCancerAnswers = SKIN_CANCER_PROGNOSIS_ANSWER_OPTIONS_MALE;
      }
      else if (UserDetails.getUserData()['gender'] == "female") {

        cancerPrognosisAttributes = SKIN_CANCER_PROGNOSIS_QUESTIONS_FEMALE;
        skinCancerAnswers = SKIN_CANCER_PROGNOSIS_ANSWER_OPTIONS_FEMALE;
      }
    }
  }

  @override
  CancerPrognosisState createState() =>
      CancerPrognosisState(cancerType, cancerPrognosisAttributes, skinCancerAnswers, url);
}

class CancerPrognosisState extends State<CancerPrognosis> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  List<Widget> itemsData = [];
  List<TextEditingController> textFieldControllers = [];
  List<String> skinCancerUserAnswers= [];
  Map prognosisBody;
  final _firestore = FirebaseFirestore.instance;
  var cancerType;
  var cancerPrognosisAttributes;
  var skinCancerAnswers;
  var url;
  var count = 0;
  var skinGroupValue = 0;

  CancerPrognosisState(var cancerType, var cancerPrognosisAttributes,
      var skinCancerAnswers,var url) {

    this.cancerType = cancerType;
    this.cancerPrognosisAttributes = cancerPrognosisAttributes;
    this.skinCancerAnswers = skinCancerAnswers;
    this.url = url;
  }

  // https://stackoverflow.com/questions/50278258/http-post-with-json-on-body-flutter-dart <- REFERENCE
  Future<String> apiRequest() async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    print(request);
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(prognosisBody)));
    HttpClientResponse response = await request.close();
    print(response);
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    httpClient.close();
    return reply;
  }

  void getPostsDataSkin() {

    for (String question in cancerPrognosisAttributes) {

      if (question != "Age") {
        skinCancerUserAnswers.add("");
        print(question);
      }
    }

    print(skinCancerUserAnswers);

    List<dynamic> responseList = cancerPrognosisAttributes;
    List<Widget> listItems = [];
    responseList.forEach((post) {

      if (count == 0) {

        textFieldControllers.add(new TextEditingController());
        listItems.add(
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18)),
                child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    child: Container(
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          margin: EdgeInsets.only(top: 0, bottom: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color(0xFFABD8E2),
                          ),
                          child: Column(
                              children: <Widget>[
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
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: textFieldControllers[count],
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white),
                                        borderRadius: new BorderRadius.circular(
                                            16),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white),
                                        borderRadius: new BorderRadius.circular(
                                            16),
                                      ),
                                      hintText: 'Enter the Value for the Input'),
                                ),
                              ]
                          )
                      ),
                    )
                )
            )
        );
      }
      else
      {
        List<String> skinCancerOptions = [];

        for (int i = 0; i < skinCancerAnswers[count - 1].length; i ++)

          skinCancerOptions.add(skinCancerAnswers[count - 1][i]);

        int currentQuestion = 0;
        currentQuestion = count - 1;

        listItems.add(
            Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18)),
                child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    child: Container(
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          margin: EdgeInsets.only(top: 0, bottom: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color(0xFFABD8E2),
                          ),
                          child: Column(
                              children: <Widget>[
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
                                    )
                                ),

                                Column(
                                  children: <Widget>[
                                    GroupButton(
                                      selectedTextStyle: TextStyle(color: Colors.white),
                                      selectedColor: Colors.redAccent,
                                      spacing: 20,
                                      onSelected: (index, isSelected) => skinCancerUserAnswers[currentQuestion] = skinCancerAnswers[currentQuestion][index],
                                      buttons: List.from(skinCancerOptions),
                                      selectedButtons: [],
                                    )
                                  ],
                                )
                              ]
                          )
                      ),
                    )
                )
            )
        );
      }
      if (count != 7)

        count ++;

    });
    setState(() {
      itemsData = listItems;
    });
  }

  void getPostsData() {
    List<dynamic> responseList = cancerPrognosisAttributes;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      textFieldControllers.add(new TextEditingController());
      listItems.add(
          Container(
              height: 150,
              // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                        child: Column(
                            children: <Widget>[
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
                              TextField(
                                controller: textFieldControllers[count],
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
                            ]
                        )
                    ),
                  )
              )
          )
      );

      count ++;
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();

    if (cancerType == "Skin Cancer")

      getPostsDataSkin();


    else getPostsData();
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
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  cancerType,
                  style: TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 27,
                    color: Color(0xFF93ACB1),
                  ),
                ),
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
              Expanded(
                  child: ListView.builder(
                      controller: controller,
                      itemCount: itemsData.length,
                      itemBuilder: (context, index) {

                        return itemsData[index];
                      }
                  )
              ),
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

                      /* If Else Conditions here to take each Input from the
                       * textFieldControllers Array, and setting the Input to
                       * each Attribute required by a Model in a Dictionary
                       * the Number Controllers will match the number of Attributes
                       * required by the Model
                       */
                      if (cancerType == "Lung Cancer") {

                        prognosisBody = {
                          "Age": textFieldControllers[0].text,
                          "Gender": textFieldControllers[1].text,
                          "AirPollution":
                          ((int.parse(textFieldControllers[2].text) / 10) *
                              8).toString(),
                          "Alcoholuse":
                          ((int.parse(textFieldControllers[3].text) / 10) *
                              8).toString(),
                          "DustAllergy":
                          ((int.parse(textFieldControllers[4].text) / 10) *
                              8).toString(),
                          "OccuPationalHazards":
                          ((int.parse(textFieldControllers[5].text) / 10) *
                              8).toString(),
                          "GeneticRisk":
                          ((int.parse(textFieldControllers[6].text) / 10) *
                              7).toString(),
                          "chronicLungDisease":
                          ((int.parse(textFieldControllers[7].text) / 10) *
                              7).toString(),
                          "BalancedDiet":
                          ((int.parse(textFieldControllers[8].text) / 10) *
                              7).toString(),
                          "Obesity":
                          ((int.parse(textFieldControllers[9].text) / 10) *
                              7).toString(),
                          "Smoking":
                          ((int.parse(textFieldControllers[10].text) / 10) *
                              8).toString(),
                          "PassiveSmoker":
                          ((int.parse(textFieldControllers[11].text) / 10) *
                              8).toString(),
                          "ChestPain":
                          ((int.parse(textFieldControllers[12].text) / 10) *
                              9).toString(),
                          "CoughingofBlood":
                          ((int.parse(textFieldControllers[13].text) / 10) *
                              9).toString(),
                          "Fatigue":
                          ((int.parse(textFieldControllers[14].text) / 10) *
                              9).toString(),
                          "WeightLoss":
                          ((int.parse(textFieldControllers[15].text) / 10) *
                              8).toString(),
                          "ShortnessofBreath":
                          ((int.parse(textFieldControllers[16].text) / 10) *
                              9).toString(),
                          "Wheezing":
                          ((int.parse(textFieldControllers[17].text) / 10) *
                              8).toString(),
                          "SwallowingDifficulty":
                          ((int.parse(textFieldControllers[18].text) / 10) *
                              8).toString(),
                          "ClubbingofFingerNails":
                          ((int.parse(textFieldControllers[19].text) / 10) *
                              9).toString(),
                          "FrequentCold":
                          ((int.parse(textFieldControllers[20].text) / 10) *
                              7).toString(),
                          "DryCough":
                          ((int.parse(textFieldControllers[21].text) / 10) *
                              7).toString(),
                          "Snoring":
                          ((int.parse(textFieldControllers[22].text) / 10) *
                              7).toString(),
                        };
                      } else if (cancerType == "Breast Cancer") {
                        print("B");
                        prognosisBody = {
                          "radius_mean": textFieldControllers[0].text,
                          "texture_mean": textFieldControllers[1].text,
                          "perimeter_mean": textFieldControllers[2].text,
                          "compactness_mean": textFieldControllers[3].text,
                          "concavity_mean": textFieldControllers[4].text,
                          "concave points_mean": textFieldControllers[5].text,
                          "fractal_dimension_mean": textFieldControllers[6].text,
                          "radius_se": textFieldControllers[7].text,
                          "texture_se": textFieldControllers[8].text,
                          "perimeter_se": textFieldControllers[9].text,
                          "compactness_se": textFieldControllers[10].text,
                          "concavity_se": textFieldControllers[11].text,
                          "concave points_se": textFieldControllers[12].text,
                          "symmetry_se": textFieldControllers[13].text,
                          "fractal_dimension_se": textFieldControllers[14].text,
                          "compactness_worst": textFieldControllers[15].text,
                          "concavity_worst": textFieldControllers[16].text,
                          "concave points_worst": textFieldControllers[17].text,
                          "symmetry_worst": textFieldControllers[18].text,
                          "fractal_dimension_worst": textFieldControllers[19].text,
                          "tumor_size": textFieldControllers[20].text,
                          "positive_axillary_lymph_node": textFieldControllers[21].text
                        };
                      }
                      else if (cancerType == "Skin Cancer")
                      {
                        List<int> skinCancerUserAnswersIndices = [];

                        int questionCount = 0;
                        int answerInQuestionCount;
                        for (String userAnswer in skinCancerUserAnswers)
                        {
                          answerInQuestionCount = 0;
                          for (String answer in skinCancerAnswers[questionCount]) {
                            if (userAnswer == answer) {
                              skinCancerUserAnswersIndices.add(answerInQuestionCount);
                              break;
                            }
                            answerInQuestionCount ++;
                          }
                          questionCount ++;
                        }

                        print(skinCancerUserAnswersIndices);

                        if (UserDetails.getUserData()['gender'] == "male")
                          prognosisBody = {

                            "age": textFieldControllers[0].text,
                            "gender": "male",
                            "sunburn": skinCancerUserAnswersIndices[1],
                            "complexion": skinCancerUserAnswersIndices[0],
                            "big-moles": skinCancerUserAnswersIndices[2],
                            "small-moles": skinCancerUserAnswersIndices[3],
                            "freckling": skinCancerUserAnswersIndices[4],
                            "damage": skinCancerUserAnswersIndices[5],
                            "tan": 0
                          };
                        else if (UserDetails.getUserData()['gender'] == "female")
                          prognosisBody = {

                            "age": textFieldControllers[0].text,
                            "gender": "female",
                            "sunburn": 0,
                            "complexion": skinCancerUserAnswersIndices[0],
                            "big-moles": 0,
                            "small-moles": skinCancerUserAnswersIndices[2],
                            "freckling": skinCancerUserAnswersIndices[3],
                            "damage": 0,
                            "tan": skinCancerUserAnswersIndices[1]
                          };

                        print(prognosisBody);
                      }

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

                      // checking if the response is not null and displaying the result
                      if (reply != null) {

                        final body = json.decode(reply);

                        print(body);

                        var prognosisResult;

                        if (cancerType != "Skin Cancer")

                          prognosisResult = body["Prediction"];

                        else
                        {
                          prognosisResult = body['result_string'];
                        }

                        /* For Breast Cancer Prognosis the Result is either 'R'
                         * for Recurring and 'N' for Non-Recurring, so an If Condition
                         * is used to set the Result to a more User Friendly
                         * message
                         */
                        if (prognosisResult == "N" &&
                            cancerType == "Breast Cancer")
                          prognosisResult = "Non-Recurring";
                        else if (prognosisResult == "R" &&
                            cancerType == "Breast Cancer")
                          prognosisResult = "Recurring";

                        print(prognosisResult);
                        // Displaying the alert dialog
                        createAlertDialog(
                            context, "Prognosis", prognosisResult, 201);

                        print("OK");
                        // Adding the response data into the database for report creation purpose
                        // initially, convert all inputs into strings for the report
                        Map firebasePrognosisBody;
                        setState(() {
                          firebasePrognosisBody = prognosisBody;

                          for (var eachItem in firebasePrognosisBody.keys) {
                            firebasePrognosisBody[eachItem] = firebasePrognosisBody[eachItem].toString();
                          }
                        });

                        _firestore
                            .collection("users")
                            .doc(UserDetails.getUserData()["email"])
                            .collection("InputPrognosis")
                            .add({
                          "prognosisInputs": firebasePrognosisBody,
                          "cancerType": cancerType,
                          "reportType": "prognosis",
                          "result": prognosisResult,
                          'timestamp': Timestamp.now(),
                        });
                      } else {
                        // Displaying the alert dialog
                        createAlertDialog(context, "Error",
                            "Oops something went wrong!", 404);
                      }
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}