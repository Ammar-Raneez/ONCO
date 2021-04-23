import 'package:flutter/material.dart';
import 'package:ui/screens/settings_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  var iconButton; // This Variable holds the Icon type required for the left part of the App Bar
  // Constructor for the RoundedAppBar Component
  CustomAppBar.arrow(BuildContext context) {
    this.iconButton = new IconButton(
      icon: Icon(
        Icons.arrow_back_sharp,
        color: Colors.white,
        size: 25.0,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  CustomAppBar.settings(
      String userName, String email, String gender, BuildContext context) {
    this.iconButton = new IconButton(
      icon: Icon(
        Icons.settings,
        color: Colors.white,
        size: 25.0,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SettingsScreen(userName, email, gender)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new SizedBox.fromSize(
      size: preferredSize,
      child: ClipPath(
        clipper: CustomShape(),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Color(0xff01CDFA),
          ),
          child: Row(

              //Setting MainAxisAlignment to spaceBetween as it creates an equal amount of space between two nodes
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: iconButton,
                    padding: EdgeInsets.only(left: 20, bottom: 30)),
                Container(
                    child: Image(
                        image: AssetImage('images/officialLogo.png'),
                        width: 65),
                    padding: EdgeInsets.only(right: 30, bottom: 30))
              ]),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120.0);
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * .5);

    var firstControlPoint = Offset(0, size.height * .75);
    var firstEndPoint = Offset(size.width / 8, size.height * .75);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width / 1.2, size.height * .75);

    var secControlPoint = Offset(size.width, size.height * .75);
    var secEndPoint = Offset(size.width, size.height * 0.98);

    path.quadraticBezierTo(
        secControlPoint.dx, secControlPoint.dy, secEndPoint.dx, secEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
