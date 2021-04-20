import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/constants.dart';
import 'package:ui/screens/Meal%20Plan/meal_detail_screen.dart';

import 'model/recipe.dart';

class AllMealScreen extends StatelessWidget {
  static String id = "allMealScreen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar.arrow(context),
          body: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: SearchPage<Recipe>(
                      searchLabel: 'Search Recipes',
                      suggestion: Center(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('images/recipe.jpg'),
                            ),
                          ),
                        ),
                      ),
                      builder: (recipes) => ListTile(
                        title: Text(recipes.title),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MealDetailScreen(
                                title: recipes.title,
                                imgUrl: recipes.imageUrl,
                                ingredients: recipes.ingredients,
                                steps: recipes.steps,
                                duration: recipes.duration,
                              ),
                            ),
                          );
                        },
                      ),
                      filter: (recipes) => [
                        recipes.title,
                      ],
                      items: RECIPES,
                      failure: Center(
                        child: Container(
                          child: Text('No Data Found'),
                        ),
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 18, right: 18, bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFEFEFEF),
                    ),
                    width: double.infinity,
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.search,
                                color: Colors.black38,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Search Recipes",
                                style: kTextStyle.copyWith(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: RECIPES.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 9,
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
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Text(
                                          RECIPES[index].title,
                                          style: kTextStyle.copyWith(
                                              fontSize: 19,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xFF09738D),
                                          ),
                                          height: 50,
                                          width: 120,
                                          child: Center(
                                            child: Text(
                                              '${RECIPES[index].duration}',
                                              style: kTextStyle.copyWith(
                                                color: Colors.white,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
