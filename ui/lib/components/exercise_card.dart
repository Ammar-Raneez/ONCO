import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExcerciseCard extends StatelessWidget {

  final String cardTitle;
  final String cardImage;

  const ExcerciseCard({@required this.cardTitle, @required this.cardImage});

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 12),
    child: Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        color: Color(0xFFFFAA9090),
        child: Container(
          width: 230.0,
          height: 284.0,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              cardTitle,
            ),
          ),
        ),
      ),
    ),
  );
}
