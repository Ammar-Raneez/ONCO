import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext mContext) {
    return MaterialApp(
        home: SafeArea(
            child: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.blue,
                          Colors.lightBlue,
                          Colors.lightBlueAccent
                        ])),

                //A ListView Widget That will contain the entire page making it scrollable if any content exceeds the page
                child: ListView(
                  //children contains multiple child widgets of the Page
                  children: [
                    //Creating a Row for the Top Header of the Page
                    Row(

                      //Setting MainAxisAlignment to spaceBetween as it creates an equal amount of space between two nodes
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Image(
                                      image: AssetImage('images/officialLogo.png'),
                                      width: 100)),
                              padding: EdgeInsets.only(top: 10, left: 20)),
                          Container(
                              height: 150,
                              child: IconButton(
                                icon: Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                              padding: EdgeInsets.only(top: 10, right: 20)),
                        ]),

                    Container(
                      height: 1000,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.only(topRight: Radius.circular(100.0)),
                          color: Colors.white,
                        ),
                        child: Text(
                          'TEST ME ABC ',
                          textScaleFactor: 2,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}