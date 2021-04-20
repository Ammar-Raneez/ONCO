import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  static String id = "mealDetailScreen";

  final String title;
  final String ingredients;
  final String steps;
  final String imgUrl;
  final String duration;
  final String forCancer;

  MealDetailScreen(
      {this.title, this.imgUrl, this.ingredients, this.duration, this.steps, this.forCancer});

  Widget _buildContainer(Widget child) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0)
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
                  style: TextStyle(fontSize: 16, color: Colors.white,
                    fontFamily: 'Poppins-SemiBold',

                  ),
                ),
                background: Image.network(
                  imgUrl,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ];
        },
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 25,bottom: 20
              ),
              child: Text(
                'Made for '+duration,
                style: TextStyle(
                  fontFamily: 'Poppins-SemiBold',
                  fontSize: 17,
                  color: Color(0xFF09738D),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 25
              ),
              child: Text(
                'Ingredients',
                style: TextStyle(
                  fontFamily: 'Poppins-SemiBold',
                  fontSize: 20,
                  color: Color(0xFF0D3945),
                ),
              ),
            ),
            _buildContainer(
              Text(
                ingredients,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontFamily: 'Poppins-SemiBold',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 25
              ),
              child: Text(
                'Steps',
                style: TextStyle(
                  fontFamily: 'Poppins-SemiBold',
                  fontSize: 20,
                  color: Color(0xFF343434),
                ),
              ),
            ),
            Container(
              child: _buildContainer(
                Text(
                  steps,
                  style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'Poppins-SemiBold',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
