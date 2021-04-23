import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui/constants.dart';

class MealDetailScreen extends StatelessWidget {
  static String id = "mealDetailScreen";

  final String title;
  final String ingredients;
  final String steps;
  final String imgUrl;
  final String duration;
  final String forCancer;

  MealDetailScreen(
      {this.title,
      this.imgUrl,
      this.ingredients,
      this.duration,
      this.steps,
      this.forCancer});

  Container _buildContainer(Widget child) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: double.infinity,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrollable) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 230,
              titleSpacing: 2.0,
              backgroundColor: const Color(0xFF09738D),
              centerTitle: true,
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  title,
                  style: kTextStyle.copyWith(fontSize: 16, color: Colors.white),
                ),
                background: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                  ),
                  imageUrl: imgUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25, bottom: 20),
              child: Text(
                'Made for ' + duration,
                style: kTextStyle.copyWith(
                  fontSize: 17,
                  color: Color(0xFF09738D),
                ),
              ),
            ),
            _commonText(text: 'Ingredients'),
            _buildContainer(
              _commonParagraph(type: ingredients),
            ),
            _commonText(text: 'Steps'),
            Container(
              child: _buildContainer(
                _commonParagraph(type: steps),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _commonText({String text}) {
    return Padding(
      padding: EdgeInsets.only(left: 25),
      child: Text(
        text,
        style: kTextStyle.copyWith(
          fontSize: 20,
          color: Color(0xFF0D3945),
        ),
      ),
    );
  }

  Text _commonParagraph({String type}) {
    return Text(
      type,
      style: kTextStyle.copyWith(fontSize: 14, color: Colors.black),
    );
  }
}
