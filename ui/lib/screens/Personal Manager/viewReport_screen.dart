import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';

class ViewReport extends StatefulWidget {
  @override
  _ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  var arr = ['a','b','c','d','e'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.arrow(context),
      body: SafeArea(
        child: Container(
          child:Column(
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
                        "28th April 2021",
                        style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 27,
                            color: Color(0xFF00404E)
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom:15
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Lung Cancer Prognosis",
                        style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 19,
                            color: Color(0xFF3C707B)
                        ),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20
                        ),
                        child: Text("Age : 21",
                          style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 17,
                              color: Color(0xFF3C707B)
                          ),
                        ),
                      ),
                      Text("Gender : Male",
                        style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 17,
                            color: Color(0xFF3C707B)
                        ),
                      )
                    ],
                  ),
                  
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 20
                        ),
                        child: Text("Prognosis Status : ",
                          style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 20,
                              color: Color(0xFF3C707B)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20
                        ),
                        child: Text("High",
                          style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 20,
                              color: Color(0xFFE32121)
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 15,
                      bottom: 10
                    ),
                    child: Text("INPUTS PROVIDED",
                      style: TextStyle(
                          fontFamily: 'Poppins-SemiBold',
                          fontSize: 18,
                          color: Color(0xFF7CC2C4)
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 100
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20,top: 10
                              ),
                              child: Text("Air Pollution",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 30,top: 10
                              ),
                              child: Text("7",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20,top: 10
                              ),
                              child: Text("Alcohol Usage",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 30,top: 10
                              ),
                              child: Text("9",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20,top: 10
                              ),
                              child: Text("Dust Allergy",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 30,top: 10
                              ),
                              child: Text("2",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20,top: 10
                              ),
                              child: Text("Occupational Hazards",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 30,top: 10
                              ),
                              child: Text("7",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20,top: 10
                              ),
                              child: Text("Genetic Risk",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 30,top: 10
                              ),
                              child: Text("7",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20,top: 10
                              ),
                              child: Text("Chronic Lung Disease",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 30,top: 10
                              ),
                              child: Text("7",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20,top: 10
                              ),
                              child: Text("Balanced Diet",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 30,top: 10
                              ),
                              child: Text("4",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20,top: 10
                              ),
                              child: Text("Obesity",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 30,top: 10
                              ),
                              child: Text("3",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 15,
                                    color: Color(0xFF515151)
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
