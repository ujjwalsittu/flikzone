import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

class FloatingBar extends StatelessWidget {
  FloatingBar({Key? key}) : super(key: key);
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => FabCircularMenu(
        key: fabKey,
        // Cannot be `Alignment.center`
        alignment: Alignment.bottomCenter,

        ringColor: Colors.black.withAlpha(55),
        ringDiameter: 500.0,
        ringWidth: 150.0,
        fabSize: 50.0,
        fabElevation: 8.0,
        fabIconBorder: CircleBorder(),
        // Also can use specific color based on wether
        // the menu is open or not:
        // fabOpenColor: Colors.white
        // fabCloseColor: Colors.white
        // These properties take precedence over fabColor
        fabColor: Colors.pinkAccent,
        fabOpenIcon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        fabCloseIcon: Icon(Icons.close),
        fabMargin: const EdgeInsets.all(16.0),
        animationDuration: const Duration(milliseconds: 800),
        animationCurve: Curves.easeInOutCirc,
        onDisplayChange: (isOpen) {
          print("The menu is ${isOpen ? "open" : "closed"}");
        },
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {
              print("You pressed 1");
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            child: Icon(Icons.add, color: Colors.white),
          ),
          RawMaterialButton(
            onPressed: () {
              print("You pressed 2");
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            child: Icon(Icons.video_call, color: Colors.white),
          ),
          RawMaterialButton(
            onPressed: () {
              print("You pressed 3");
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            child: Icon(Icons.photo_camera, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
