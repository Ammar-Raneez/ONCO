import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';

class TimerPage extends StatefulWidget {
  final String name_1;
  final String name_2;
  final String name_3;

  const TimerPage(this.name_1, this.name_2, this.name_3);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  String time = "";
  String workout = "";
  Timer _timer;

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      if(DateTime.now().second == 5){ //Stop if second equal to 5
        timer.cancel();
        workout = "Please Take a Break";
      }
      setState(() {
       workout = "After Some time ${DateTime.now().second}";
      });
      setState(() {
        time = "${DateTime
            .now()
            .second}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar.arrow(context),
              Container(
                child: Text(time, style: TextStyle(
                  fontFamily: 'Poppins-SemiBold',
                  fontSize: 24,
                ),),
              ),
            ],
          ),
        )
    );
  }
}

