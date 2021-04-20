import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/constants.dart';
import 'package:ui/screens/Meal%20Plan/meal_detail_screen.dart';

class AllMealScreen extends StatelessWidget {
  static String id = "allMealScreen";
  // Container(
  // child: Text(
  // "Search"
  // ),
  // ),
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar.arrow(context),
        body: Container(
          child: ListView.builder(
            shrinkWrap: true,
              itemCount: RECIPES.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealDetailScreen(
                          title: RECIPES[index].title,
                          imgUrl: RECIPES[index].imageUrl,
                          ingredients: RECIPES[index].ingredients,
                          steps: RECIPES[index].steps,
                          duration: RECIPES[index].duration,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    elevation: 4.0,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            RECIPES[index].imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 180,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)
                              )
                            ),
                            child: Text(
                              RECIPES[index].title,
                              style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontSize: 19,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFF034D5D)),
                              height: 50,
                              width: 120,
                              child: Center(
                                child: Text(
                                  '${RECIPES[index].duration}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 13,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
