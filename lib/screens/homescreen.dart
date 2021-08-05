import 'package:flickzone/widgets/appBar.dart';
import 'package:flickzone/widgets/navbar.dart';
import 'package:flickzone/widgets/posts.dart';
import 'package:flickzone/widgets/stories.dart';
import 'package:flutter/material.dart';
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
      appBar: buildAppBar(),
      body: SafeArea(
        child: SimpleGestureDetector(
          onHorizontalSwipe: _onHorizontalSwipe,
          child: Column(
            children: [
              Container(
                color: Vx.pink100,
                child: Column(
                  children: [
                    VxContinuousRectangle(
                      backgroundColor: Vx.gray50,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                            child: CircleAvatar(
                              maxRadius: 25,
                              backgroundImage: NetworkImage(box
                                          .get('profilepic') !=
                                      null
                                  ? box.get('profilepic')
                                  : "https://image.flaticon.com/icons/png/512/3237/3237472.png"),
                            ),
                          ),
                          VxCapsule(
                            width: 280,
                            height: 50,
                            backgroundColor: Vx.white,
                            shadows: [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 0.01,
                                  blurRadius: 1)
                            ],
                            child: Center(
                              child: "Write Something here....".text.make(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/icons/send.png",
                              scale: 3,
                            ),
                          ),
                        ],
                      ),
                    ).shadow2xl,
                    VxContinuousRectangle(
                      radius: 0,
                      height: 40,
                      backgroundColor: Vx.gray50,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset("assets/images/photos.png"),
                                " Photos".text.make()
                              ],
                            ),
                            "|".text.blueGray500.make(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset("assets/images/film.png"),
                                " ShortFlick".text.make()
                              ],
                            ),
                            "|".text.blueGray500.make(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset("assets/images/video.png"),
                                " Videos".text.make()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ).shadowXs,
                  ],
                ),
              ),
              new SizedBox(
                child: new Stories(),
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Flexible(child: Post())
            ],
          ),
        ),
      ),
      floatingActionButton: VxCircle(
        child: GestureDetector(
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => VideoScreen()));
          },
          child: (Icon(
            Icons.add,
            color: Vx.white,
          )),
        ),
        radius: 50,
        backgroundColor: Vx.lightBlue400,
      ),
      bottomNavigationBar: bottomBar(),
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
