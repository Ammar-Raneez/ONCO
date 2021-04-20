import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/constants.dart';
import 'package:ui/screens/Meal%20Plan/meal_detail_screen.dart';
import 'package:ui/screens/Meal%20Plan/model/recipe.dart';

class AllMealScreen extends StatelessWidget {
  static String id = "allMealScreen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//        appBar: CustomAppBar.arrow(context),
      appBar: AppBar(
        title: Text('Dietary Plans'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: SearchPage<Recipe>(
                searchLabel: 'Search Cancer Meal Recipes',
                suggestion: Center(
                  child: Container(
                    height: 400,
                    width: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/recipe.jpg'),
                        fit: BoxFit.fill,
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
                        builder: (context) => AllMealScreen(),
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
            ),
          ),
        ],
      ),
        body: ListView.builder(
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  elevation: 4.0,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          RECIPES[index].imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 150,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                          ),
                          child: Text(
                            RECIPES[index].title,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              color: Colors.white),
                          height: 25,
                          width: 100,
                          child: Center(
                            child: Text(
                              '${RECIPES[index].duration}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
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
    );
  }
}
