import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ViewReport extends StatefulWidget {
  String cancerType;
  String inputImageUrl;
  String imageUrl;
  String result;
  String resultString;
  String percentage;
  String reportType;
  var reportDate;
  Map prognosisInputs;

  ViewReport(
      context,
      this.cancerType,
      this.inputImageUrl,
      this.imageUrl,
      this.result,
      this.resultString,
      this.percentage,
      this.reportType,
      this.reportDate,
      this.prognosisInputs);

  @override
  _ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  String formattedDate;
  Color indicatorColor;
  Map prognosisVariables;
  var _reportResult;

  List<Widget> itemsData = [];
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    var date =
        DateTime.fromMillisecondsSinceEpoch(widget.reportDate.millisecondsSinceEpoch);
    formattedDate = DateFormat.yMMMd().format(date);

    print(widget.cancerType);

    if (widget.result == "CANCER") {
      _reportResult = widget.resultString;
    } else {
      _reportResult = widget.result;
    }
    prognosisVariables = widget.prognosisInputs;

    if (widget.reportType == "prognosis") {
      getPostsData(prognosisVariables);
    } else {
      if (double.parse(widget.percentage) > 70.0) {
        indicatorColor = Color(0XFFeb4034);
      } else if (double.parse(widget.percentage) > 40.0) {
        indicatorColor = Color(0XFFf5cd3d);
      } else if (double.parse(widget.percentage) < 40.0) {
        indicatorColor = Color(0XFF7bd130);
      }
    }
  }

  void getPostsData(Map prognosisBody) {
    List<dynamic> responseList = [];
    prognosisBody.forEach((k, v) => {responseList.add(k + " : " + v)});

    List<Widget> listItems = [];
    listItems.add(
      Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    formattedDate,
                    style: TextStyle(
                      fontFamily: 'Poppins-SemiBold',
                      fontSize: 27,
                      color: Color(0xFF00404E),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.cancerType.toUpperCase() + " " + widget.reportType.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Poppins-SemiBold',
                      fontSize: 19,
                      color: Color(0xFF3C707B),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 15,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Result :",
                style: TextStyle(
                  fontFamily: 'Poppins-SemiBold',
                  fontSize: 18,
                  color: Color(0xFF7CC2C4),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 5,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _reportResult.toString().toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Poppins-SemiBold',
                  fontSize: 14,
                  color: Color(0xFF1F1F1F),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "INPUTS PROVIDED",
                style: TextStyle(
                  fontFamily: 'Poppins-SemiBold',
                  fontSize: 18,
                  color: Color(0xFF7CC2C4),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    responseList.forEach((post) {
      listItems.add(
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 5, bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              post.toString().toUpperCase(),
              style: TextStyle(
                fontFamily: 'Poppins-SemiBold',
                fontSize: 14,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      );
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar.arrow(context),
        body: SafeArea(
          child: Container(
            child: cancerDetails(
                context,
                formattedDate,
                widget.reportType,
                widget.cancerType,
                _reportResult,
                widget.percentage,
                widget.inputImageUrl,
                widget.imageUrl,
                prognosisVariables,
                controller,
                itemsData,
                indicatorColor),
          ),
        ),
      ),
    );
  }
}

Widget percentageContainer(String percentages) {
  if (percentages != null) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 10,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Percentage : ",
              style: TextStyle(
                fontFamily: 'Poppins-SemiBold',
                fontSize: 18,
                color: Color(0xFF7CC2C4),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 5,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              double.parse(percentages).floor().toString(),
              style: TextStyle(
                fontFamily: 'Poppins-SemiBold',
                fontSize: 14,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ],
    );
  } else {
    return Container(
      child: Text(""),
    );
  }
}

Widget cancerDetails(
    BuildContext context,
    String date,
    String reportType,
    String cancerType,
    String reportResult,
    String percentage,
    String inputImageUrl,
    String imageUrl,
    Map prognosisBody,
    ScrollController controller,
    List<Widget> itemsData,
    Color color) {
  // DIAGNOSIS
  if (reportType.toLowerCase() == "diagnosis") {
    return ListView(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90, right: 23),
              child: Align(
                alignment: Alignment.topRight,
                child: CircularPercentIndicator(
                  radius: 150.0,
                  lineWidth: 20,
                  animation: true,
                  animationDuration: 1000,
                  percent: double.parse(percentage) / 100,
                  center: new Text(
                      double.parse(percentage).floor().toString() + "%"),
                  progressColor: color,
                ),
              ),
            ),
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 20,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          date,
                          style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 27,
                            color: Color(0xFF00404E),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          cancerType.toUpperCase() +
                              " " +
                              reportType.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 19,
                            color: Color(0xFF3C707B),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                percentageContainer(percentage),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 15,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Result :",
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 18,
                        color: Color(0xFF7CC2C4),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 5,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      reportResult.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 14,
                        color: Color(0xFF1F1F1F),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "INPUTS PROVIDED",
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 18,
                        color: Color(0xFF7CC2C4),
                      ),
                    ),
                  ),
                ),
                cancerType != "skin cancer"
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: CachedNetworkImage(
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                          ),
                          imageUrl: inputImageUrl,
                          width: MediaQuery.of(context).size.width,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: CachedNetworkImage(
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                          ),
                          imageUrl: imageUrl,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                SizedBox(
                  height: 30,
                ),
                cancerType != "skin cancer"
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "OUTPUTS OBTAINED",
                            style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontSize: 18,
                                color: Color(0xFF7CC2C4)),
                          ),
                        ),
                      )
                    : Container(
                        height: 0,
                      ),
                cancerType != "skin cancer"
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: CachedNetworkImage(
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                          ),
                          imageUrl: imageUrl,
                          height: 450,
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                        ),
                      )
                    : Container(
                        height: 0,
                      ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  } else {
    // PROGNOSIS
    return ListView.builder(
        controller: controller,
        itemCount: itemsData.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return itemsData[index];
        });
  }
}
