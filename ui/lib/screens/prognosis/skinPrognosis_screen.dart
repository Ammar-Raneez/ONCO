import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/components/rounded_button.dart';
import 'package:ui/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SkinCancerPrognosis(),
    );
  }
}

class SkinCancerPrognosis extends StatefulWidget {
  @override
  _SkinCancerPrognosisState createState() => _SkinCancerPrognosisState();
}

class _SkinCancerPrognosisState extends State<SkinCancerPrognosis> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = SKIN_CANCER_PROGNOSIS_QUESTIONS;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(
          Container(
              height: 190,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Container(
                    child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                        margin: EdgeInsets.only(top: 0, bottom: 50),
                        width: double.infinity,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFABD8E2),
                        ),
                        child: Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child:Text(
                                    post,
                                    style: kTextStyle.copyWith(
                                      color: Colors.blueGrey,
                                      fontSize: 18,
                                    ),
                                  )
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.white),
                                      borderRadius: new BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.white),
                                      borderRadius: new BorderRadius.circular(25.7),
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
      double value = controller.offset / 119;

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
        appBar: CustomAppBar("arrow", context),
        body:  Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Skin Cancer",
                  style: kTextStyle.copyWith(
                    color: Colors.blueGrey,
                    fontSize: 25,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Prognosis",
                  style: kTextStyle.copyWith(
                    color: Colors.black54,
                    fontSize: 25,
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
                  shape: const StadiumBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const SKIN_CANCER_PROGNOSIS_QUESTIONS =
[
  "Radius Mean",
  "Radius SE",

  "Texture Mean",
  "Texture SE",

  "Perimeter Mean",
  "Perimeter SE",

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
