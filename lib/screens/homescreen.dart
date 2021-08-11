import 'package:collapsible/collapsible.dart';
import 'package:flickzone/screens/LongVideoScreen.dart';
import 'package:flickzone/widgets/appBar.dart';
import 'package:flickzone/widgets/floatingBar.dart';
import 'package:flickzone/widgets/navbar.dart';
import 'package:flickzone/widgets/posts.dart';
import 'package:flickzone/widgets/stories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:velocity_x/velocity_x.dart';

String kHomeRoute = "/home";

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onHorizontalSwipe(SwipeDirection direction) {
    setState(() {
      if (direction == SwipeDirection.right) {
        Navigator.pushNamed(context, "/short");
      }
    });
  }

  var box = Hive.box('OTP');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset(
            "assets/images/logo-black.png",
          ),
        ),
        leadingWidth: 250,
        elevation: 0,
        actions: [
          Image.asset(
            'assets/icons/home.png',
            scale: 2.5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, kVideoScreen);
            },
            child: Image.asset(
              'assets/icons/video.png',
              scale: 5.5,
            ),
          ),
          // Image.asset(
          //   'assets/icons/message.png',
          //   scale: 5.5,
          // ),
        ],
      ),
      body: SafeArea(
        child: SimpleGestureDetector(
          onHorizontalSwipe: _onHorizontalSwipe,
          child: Column(
            children: [
              SizedBox(
                child: new Stories(),
                height: MediaQuery.of(context).size.height * 0.14,
              ),
              Flexible(child: Post())
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingBar(),
      // VxCircle(
      //   child: GestureDetector(
      //     onTap: () {
      //       // Navigator.push(context,
      //       //     MaterialPageRoute(builder: (context) => VideoScreen()));
      //     },
      //     child: (Icon(
      //       Icons.add,
      //       color: Vx.white,
      //     )),
      //   ),
      //   radius: 50,
      //   backgroundColor: Vx.lightBlue400,
      // ),
      bottomNavigationBar: bottomBar(),
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
