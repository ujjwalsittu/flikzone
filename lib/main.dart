import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flickzone/screens/Camera_Uploader.dart';
import 'package:flickzone/screens/LongVideoScreen.dart';
import 'package:flickzone/screens/LongVideoUpload.dart';
import 'package:flickzone/screens/PostUpload.dart';
import 'package:flickzone/screens/ShortFlick.dart';
import 'package:flickzone/screens/UploadStory.dart';
import 'package:flickzone/screens/VideoRecorder.dart';
import 'package:flickzone/screens/feed_screen.dart';
import 'package:flickzone/screens/homescreen.dart';
import 'package:flickzone/screens/login.dart';
import 'package:flickzone/screens/SingleLongVideo.dart';
import 'package:flickzone/screens/messages.dart';
import 'package:flickzone/screens/notifications.dart';
import 'package:flickzone/screens/profile.dart';
import 'package:flickzone/screens/profileOther.dart';
import 'package:flickzone/screens/profileUpdate.dart';
import 'package:flickzone/screens/search.dart';
import 'package:flickzone/service_locator.dart';
import 'package:flickzone/widgets/firsttab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

Future<void> main() async {
  // var dio = Dio(
  //   BaseOptions(
  //       baseUrl: 'http://apiv1.flikzone.com/',
  //       connectTimeout: 5000,
  //       receiveTimeout: 100000,
  //       contentType: Headers.jsonContentType),
  // );
  await Hive.initFlutter();
  if (Hive.isBoxOpen('OTP')) {
    print("Box Is Open");
  } else {
    await Hive.openBox('OTP');
  }
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();

  late int randomOTP;
  int max = 999999;
  int min = 100000;
  var randomGen = new Random();
  randomOTP = min + randomGen.nextInt(max - min);
  var box = Hive.box('OTP');
  box.put('otp', randomOTP);
  runApp(const MyApp());
  print(box.containsKey('islogged'));
  print(box.get('otp'));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flickzone",
      theme: ThemeData(),
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      routes: {
        "/first": (context) => FirstTab(),
        "/": (context) => SplashScreen(),
        "/short": (context) => ShortFlik(),
        "/updateProfile": (context) => ProfileUpdate(),
        kVideoScreen: (context) => LongVideoScreen(),
        kMessage: (context) => MessageScreen(),
        kHomeRoute: (context) => HomeScreen(),
        kSearchPage: (context) => SearchPage(),
        "/upload": (context) => LongVideoUpload(),
        // "/postcreate": (context) => PostUpload(),
        // "/videorec": (context) => VideoRecorder(),
        "/picker": (context) => Picker(),
        kNotificationRoute: (context) => Notifications(),
        kProfileScreen: (context) => ProfileScreen(),
        "/storyupload": (context) => StoryUpload(),
      },
    );
  }
}

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var box = Hive.box('OTP');

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: box.containsKey('islogged') ? HomeScreen() : LoginPage(),
      duration: 5000,
      imageSize: 130,
      imageSrc: "assets/images/icon.png",
      // text: "FlickZone",
      // textType: TextType.ColorizeAnimationText,
      // textStyle: TextStyle(
      //   fontSize: 40.0,
      // ),
      backgroundColor: Colors.white,
    );
  }
}
