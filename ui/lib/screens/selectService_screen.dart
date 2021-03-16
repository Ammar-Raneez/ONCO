import 'package:flutter/material.dart';
import 'package:ui/components/treatment_card.dart';


class SelectServiceScreen extends StatefulWidget {
    @override
    _SelectServiceScreenState createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child:(
              TreatmentCard()
            ),
          ),
        ),
      );
  }
}