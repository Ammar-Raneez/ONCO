import 'package:flutter/material.dart';
import 'package:ui/components/cancer_card.dart'; //imports card component
import 'package:ui/screens/diagnosis/breastDiagnosis_screen.dart';
import 'package:ui/screens/diagnosis/lungDiagnosis_screen.dart';
import 'package:ui/screens/diagnosis/skinDiagnosis_screen.dart';
import 'package:ui/screens/prognosis/prognosis_screen.dart';
import 'package:ui/screens/selectService_screen.dart';


//TODO - Add nav to bottom also add passing colors into card. Might need to adjust padding after(Appbar done only for nav)

/* This is the Cancer Page that displays an appbar with a gradient and a logo, three cards that allow the user to click on a
 certain cancer and be redirected to that page and the nav at the bottom. */

class MainCancerTypesScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "mainCancerTypesScreen";

  @override
  _MainCancerTypesScreenState createState() => _MainCancerTypesScreenState();
}

class _MainCancerTypesScreenState extends State<MainCancerTypesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              //* might need to change when adding top row and nav
              left: 22,
              right: 22,
              bottom: 20
            ),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      bottom: 15
                    ),
                    child: Text(
                      'Prognosis & Diagnosis of Cancers',
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 24,
                        color: Color(0xFF373737),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectServiceScreen(cancerType: 'Skin Cancer', diagnosisRoute: SkinCancerDiagnosis(), prognosisRoute: CancerPrognosis("Skin Cancer")),
                        ),
                      );
                    },
                    child: CancerCard(
                        cardTitle: 'Skin Cancer',
                        cardColor: '0xFFe0a75c',
                        textColor: '0xFFFFFFFF'),
                  ),
                  //generates a cancer card with text passed.
                  SizedBox(
                    height: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectServiceScreen(cancerType: 'Lung Cancer', diagnosisRoute: LungCancerDiagnosis(), prognosisRoute: CancerPrognosis("Lung Cancer")),
                        ),
                      );
                    },
                    child: CancerCard(
                      cardTitle: 'Lung Cancer',
                      cardColor: '0xFF5cade0',
                      textColor: '0xFFFFFFFF',
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectServiceScreen(cancerType: 'Breast Cancer',  diagnosisRoute: BreastCancerDiagnosis(),  prognosisRoute: CancerPrognosis("Breast Cancer")),
                        ),
                      );
                    },
                    child: CancerCard(
                      cardTitle: 'Breast Cancer',
                      cardColor: '0xFFe34f94',
                      textColor: '0xFFFFFFFF',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
