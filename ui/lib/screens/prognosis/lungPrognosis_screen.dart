import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';
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
      home: LungCancerPrognosis(),
    );
  }
}

class LungCancerPrognosis extends StatefulWidget {
  @override
  _LungCancerPrognosisState createState() => _LungCancerPrognosisState();
}

class _LungCancerPrognosisState extends State<LungCancerPrognosis> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = LUNG_CANCER_PROGNOSIS_QUESTIONS;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(
          Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Container(
                    child: Container(
                      margin: EdgeInsets.only(top: 0, bottom: 50),
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.blue,
                              Colors.lightBlueAccent
                            ]
                        ),
                      ),
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
        appBar: CustomAppBar("arrow", context),
        body: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          height: size.height,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Lung Cancer",
                    style: kTextStyle.copyWith(
                      color: Colors.blueGrey,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Prognosis",
                    style: kTextStyle.copyWith(
                      color: Colors.black54,
                      fontSize: 25,
                    ),
                  ),
                ],
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
            ],
          ),
        ),
      ),
    );
  }
}

const LUNG_CANCER_PROGNOSIS_QUESTIONS =
[
  "Radius Mean",
  "Radius SE",

  "Texture Mean",
  "Texture SE",

  "Perimeter Mean",
  "Perimeter_se",

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
