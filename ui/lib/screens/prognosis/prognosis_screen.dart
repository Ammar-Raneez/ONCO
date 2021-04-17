import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/constants.dart';

class CancerPrognosis extends StatefulWidget {

  var cancerType;
  var url = "https://onco-prognosis-backend.herokuapp.com/";
  var cancerPrognosisAttributes;

  CancerPrognosis(String cancerType)
  {
    this.cancerType = cancerType;

    if (cancerType == "Breast Cancer")
    {
      cancerPrognosisAttributes = BREAST_CANCER_PROGNOSIS_QUESTIONS;
      url += "prognosis_breast";
    }
    else if (cancerType == "Lung Cancer")
    {
      cancerPrognosisAttributes = LUNG_CANCER_PROGNOSIS_QUESTIONS;
      url += "prognosis_lung";
    }
    else if (cancerType == "Skin Cancer")
    {
      cancerPrognosisAttributes = SKIN_CANCER_PROGNOSIS_QUESTIONS;
    }
  }

  @override
  _CancerPrognosisState createState() => _CancerPrognosisState(cancerType, cancerPrognosisAttributes, url);
}

class _CancerPrognosisState extends State<CancerPrognosis> {

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  List<Widget> itemsData = [];
  List<TextEditingController> textFieldControllers = [];
  Map prognosisBody;
  var cancerType;
  var cancerPrognosisAttributes;
  var url;
  var count = 0;

  // https://stackoverflow.com/questions/50278258/http-post-with-json-on-body-flutter-dart <- REFERENCE
  Future<String> apiRequest() async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(prognosisBody)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  _CancerPrognosisState(var cancerType, var cancerPrognosisAttributes, var url)
  {
    this.cancerType = cancerType;
    this.cancerPrognosisAttributes = cancerPrognosisAttributes;
    this.url = url;
  }

  void getPostsData() {
    List<dynamic> responseList = cancerPrognosisAttributes;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      count ++;
      textFieldControllers.add(new TextEditingController());
      listItems.add(
          Container(
              height: 190,
              // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18)
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Container(
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        margin: EdgeInsets.only(top: 0, bottom: 50),
                        width: double.infinity,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Color(0xFFABD8E2),
                        ),
                        child: Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child:Text(
                                    post,
                                    style:TextStyle(
                                      fontFamily: 'Poppins-SemiBold',
                                      color: Colors.blueGrey,
                                      fontSize: 20,
                                    ),
                                  )
                              ),
                              TextField(
                                controller: textFieldControllers[count - 1],
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
                                    hintText: 'Enter the Value for the Input'
                                ),
                              ),
                            ]
                        )
                    ),
                  )
              )
          )
      );
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {
      double value = controller.offset / 150;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar.arrow(context),
        body:  Container(
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
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        double scale = 1.0;
                        if (topContainer > 0.5) {
                          scale = index + 0.5 - topContainer;
                          if (scale < 0) {
                            scale = 0;
                          } else if (scale > 1) {
                            scale = 1;
                          }
                        }
                        return Opacity(
                          opacity: scale,
                          child: Transform(
                            transform: Matrix4.identity()..scale(scale, scale),
                            alignment: Alignment.bottomCenter,
                            child: Align(
                                heightFactor: 0.7,
                                alignment: Alignment.topCenter,
                                child: itemsData[index]),
                          ),
                        );
                      })
              ),
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
                            "Predict",
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
                    shape: const StadiumBorder(), onPressed: () async {

                      if (cancerType == "Lung Cancer") {
                        prognosisBody = {
                          "Age": textFieldControllers[0].text,
                          "Gender": textFieldControllers[1].text,
                          "AirPollution": textFieldControllers[2].text,
                          "Alcoholuse": textFieldControllers[3].text,
                          "DustAllergy": textFieldControllers[4].text,
                          "OccuPationalHazards": textFieldControllers[5].text,
                          "GeneticRisk": textFieldControllers[6].text,
                          "chronicLungDisease": textFieldControllers[7].text,
                          "BalancedDiet": textFieldControllers[8].text,
                          "Obesity": textFieldControllers[9].text,
                          "Smoking": textFieldControllers[10].text,
                          "PassiveSmoker": textFieldControllers[11].text,
                          "ChestPain": textFieldControllers[12].text,
                          "CoughingofBlood": textFieldControllers[13].text,
                          "Fatigue": textFieldControllers[14].text,
                          "WeightLoss": textFieldControllers[15].text,
                          "ShortnessofBreath": textFieldControllers[16].text,
                          "Wheezing": textFieldControllers[17].text,
                          "SwallowingDifficulty": textFieldControllers[18].text,
                          "ClubbingofFingerNails": textFieldControllers[19].text,
                          "FrequentCold": textFieldControllers[20].text,
                          "DryCough": textFieldControllers[21].text,
                          "Snoring": textFieldControllers[22].text,
                        };
                      }
                      else if (cancerType == "Breast Cancer")
                      {
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
                      print(prognosisBody);
                      print(await apiRequest());
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
