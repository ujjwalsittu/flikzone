import 'dart:convert';

import 'package:advance_image_picker/widgets/picker/image_picker.dart';
import 'package:flickzone/constants.dart';
import 'package:flickzone/models/StoryModel.dart';
import 'package:flickzone/screens/LongVideoScreen.dart';
import 'package:flickzone/screens/ShortFlikScreen.dart';
import 'package:flickzone/screens/notifications.dart';
import 'package:flickzone/screens/profile.dart';
import 'package:flickzone/screens/search.dart';
import 'package:flickzone/widgets/StoryWebServices.dart';

import 'package:flickzone/widgets/posts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_story_list/flutter_story_list.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:imgly_sdk/imgly_sdk.dart';
import 'package:video_editor_sdk/video_editor_sdk.dart';

String kHomeRoute = "/home";

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    profileDetails();
    loadStories();
  }

  List<StoryModel> storyList = <StoryModel>[];
  int storyLength = 0;
  void loadStories() async {
    var box = Hive.box('OTP');
    int userid = box.get('userid');
    final respi = await StoryWebServices().loadStory();
    if (respi.length != 0) {
      setState(() {
        storyList = respi;
        storyLength = storyList.length;
      });
    }
  }

  String fullName = "Full Name";
  String profilePic = kDefaultPic;
  String username = "Username";

  late dynamic profileResp;
  var box = Hive.box('OTP');
  void profileDetails() async {
    int userid = box.get("userid");
    var url = Uri.http(kAppUrlHalf, 'user/$userid');
    var response = await http.get(url);
    profileResp = jsonDecode(response.body);
    setState(() {
      fullName = profileResp['data'][0]['fullName'];
      profilePic = profileResp['data'][0]['profilepic'];
      username = profileResp['data'][0]['username'];
    });
  }

  void _onHorizontalSwipe(SwipeDirection direction) {
    setState(() {
      if (direction == SwipeDirection.right) {
        Navigator.pushNamed(context, "/short");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final images = List.generate(
      storyList.length,
      (idx) => Image.network(kVideoUrl + storyList[idx].storyUrl),
    );
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
          // Image.asset(
          //   'assets/icons/home.png',
          //   scale: 2.5,
          // ),
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
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Stories",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: "Arial"),
                    )),
              ),
              StoryList(
                addItemWidth: MediaQuery.of(context).devicePixelRatio * 30,
                height: 100,
                onPressedIcon: () {
                  Navigator.pushNamed(context, "/storyupload");
                },
                image: Image.network(
                  profilePic,
                  fit: BoxFit.cover,
                ),
                text: Text(""),
                iconBackgroundColor: Colors.pinkAccent,
                iconSize: 25,
                itemCount: storyLength,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 50,
                    height: 50,
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.network(
                        kVideoUrl + storyList[index].storyUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(child: Post())
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          Alert(
            context: context,
            type: AlertType.info,
            title: "Create Flicks",
            desc: "Select Flick Type You Want to Create.",
            buttons: [
              DialogButton(
                child: Text(
                  "LongFlik",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () => Navigator.pushNamed(context, "/upload"),
                // color: Color.fromRGBO(0, 179, 134, 1.0),
              ),
              DialogButton(
                child: Text(
                  "ShortFlik",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () async {
                  // XFile? video;
                  // video = await ImagePicker().pickVideo(
                  //     source: ImageSource.camera,
                  //     maxDuration: Duration(seconds: 30));
                  // String filePath = "";
                  //
                  // setState(() {
                  //   filePath = video!.path;
                  // });
                  // toEditor(filePath);
                  // toEditor();
                  // const MethodChannel _channel =
                  //     MethodChannel('video_editor_sdk');
                  // await _channel.invokeMethod('unlock', <String, dynamic>{
                  //   'license': "assets/icons/vesdk_android_license"
                  // });
                  //
                  // final result = await VESDK.openEditor(
                  //   Video('assets/icons/sample.mp4'),
                  // );
                  // print(
                  //   result?.toJson(),
                  // );

                  Alert(
                    context: context,
                    type: AlertType.info,
                    title: "Create Flicks",
                    desc: "Select Flick Type You Want to Create.",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Camera",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        onPressed: () async {
                          // List<Media>? res = await ImagesPicker.openCamera(
                          //     pickType: PickType.video, maxTime: 60);
                        },
                        gradient: LinearGradient(
                          colors: [Vx.green700, Vx.blue500],
                        ),
                      ),
                      DialogButton(
                        child: Text(
                          "Gallery",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        onPressed: () {},
                        gradient: LinearGradient(
                          colors: [Vx.purple400, Vx.blue500],
                        ),
                      ),
                    ],
                  ).show();
                },
                // gradient: LinearGradient(colors: [
                //   Color.fromARGB(116, 116, 191, 1),
                //   Color.fromRGBO(52, 138, 199, 1.0)
                // ]),
              ),
              DialogButton(
                child: Text(
                  "PostFlik",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/picker");
                },
                // gradient: LinearGradient(colors: [
                //   Color.fromRGBO(116, 116, 191, 1.0),
                //   Color.fromRGBO(52, 138, 199, 1.0)
                // ]),
              ),
            ],
          ).show();
        },
        child: Icon(Icons.add),
      ), //FloatingBar(),
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
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 50.0,
        alignment: Alignment.center,
        child: new BottomAppBar(
          child: new Row(
            // alignment: MainAxisAlignment.spaceAround,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // new IconButton(
              //   icon: Icon(
              //     Icons.home,
              //   ),
              //   onPressed: () {
              //     Navigator.pushNamed(context, kHomeRoute);
              //   },
              // ),
              GestureDetector(
                onTap: () {},
                child: new Image.asset(
                  'assets/icons/home.png',
                  scale: 2.5,
                ),
              ),
              new IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, kSearchPage);
                },
              ),
              // new IconButton(
              //   icon: Icon(
              //     Icons.add_box,
              //   ),
              //   onPressed: null,
              // ),
              new SizedBox(),
              new IconButton(
                icon: Icon(
                  Icons.notifications,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, kNotificationRoute);
                },
              ),
              new IconButton(
                icon: Icon(
                  Icons.account_box,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, kProfileScreen);
                },
              ),
            ],
          ),
        ),
      ),
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  // void toEditor(String path) async {
  void toEditor() async {
    // VESDK.unlockWithLicense("assets/icons/vesdk_android_license");
    const MethodChannel _channel = MethodChannel('video_editor_sdk');
    await _channel.invokeMethod('unlock',
        <String, dynamic>{'license': "assets/icons/vesdk_android_license"});

    final result = await VESDK.openEditor(Video('assets/icons/sample.mp4'));
    print(result?.toJson());
  }

  void _showAlert(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Attention"),
              content: Text(message),
            ));
  }
}
