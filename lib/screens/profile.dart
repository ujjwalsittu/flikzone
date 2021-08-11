import 'dart:convert';

import 'package:flickzone/constants.dart';
import 'package:flickzone/widgets/LongVideoWebService.dart';
import 'package:flickzone/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flickzone/models/LongVideos.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

String kProfileScreen = "/profile";

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool noLV = true;
  List<LongVideo>? _longVideo = <LongVideo>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileDetails();
    _loadLV();
  }

  void _loadLV() async {
    var box = Hive.box('OTP');
    int userid = box.get('userid');
    final lvResults = await LongVideoWebService().loadLV(50);
    print(lvResults.length);
    if (lvResults.isNotEmpty) {
      setState(() {
        noLV = false;
        _longVideo = lvResults;
        print(_longVideo);
        print("ENTERED THIS BLOCK");
      });
    }
  }

  int selectedTab = 0;
  late String resp;
  String fullName = "Full Name";
  String profilePic = kDefaultPic;
  String username = "Username";
  int noOfPost = 0;
  int totalFollowers = 0;
  int totalpost = 0;
  int totalVideos = 0;
  late dynamic profileResp;
  var box = Hive.box('OTP');
  void profileDetails() async {
    int userid = box.get("userid");
    var url = Uri.http("15.207.105.12:4040", 'user/$userid');
    var response = await http.get(url);
    profileResp = jsonDecode(response.body);
    setState(() {
      fullName = profileResp['data'][0]['fullName'];
      profilePic = profileResp['data'][0]['profilepic'];
      username = profileResp['data'][0]['username'];
      noOfPost = profileResp['data'][0]['noOfLongVideo'] +
          profileResp['data'][0]['noOfLongShort'] +
          profileResp['data'][0]['noOfPost'];
      totalVideos = profileResp['data'][0]['noOfLongVideo'] +
          profileResp['data'][0]['noOfLongShort'];
      // print(noOfPost);
      totalFollowers = profileResp['data'][0]['totalFollowers'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.gray300,
        title: fullName.text.gray700.make(),
        iconTheme: IconThemeData(color: Vx.black),
        actionsIconTheme: IconThemeData(color: Vx.black),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
                onTap: () {
                  box.deleteFromDisk();
                  Navigator.pushNamed(context, "/");
                },
                child: Center(child: FaIcon(Icons.menu_open_sharp))),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: VxCircle(
                        radius: 100,
                        border: Border.all(width: 4, color: Vx.lightBlue300),
                        backgroundImage: DecorationImage(
                            image: NetworkImage(profilePic), fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        noOfPost.text.bold.gray400.xl2.make(),
                        "Posts".text.gray400.make(),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      children: [
                        totalFollowers.text.bold.gray400.xl2.make(),
                        "Followers".text.gray400.make(),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      children: [
                        totalVideos.text.bold.gray400.xl2.make(),
                        "Videos".text.gray400.make(),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    username.text.xl2.gray500.bold.make(),
                    // "Artist".text.xl.gray400.make(),
                    "Bio Goes Here".text.xl.gray500.make()
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = 0;
                          _loadLV();
                          // print(selectedTab);
                        });
                      },
                      child: Icon(Icons.apps)),
                  "|".text.make(),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = 1;
                          print(selectedTab);
                        });
                      },
                      child: Icon(Icons.center_focus_weak)),
                  "|".text.make(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = 2;
                        print(selectedTab);
                      });
                    },
                    child: Icon(Icons.play_circle_outline_sharp),
                  ),
                ],
              ),
              selectedTab == 0
                  ? Container(
                      child: noLV
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("NO LONG VIDEO FOUND"),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4),
                              itemBuilder: (BuildContext ctx, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 150,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage((kImageUrl +
                                            _longVideo![index].thumbnailUrl)),
                                        fit: BoxFit.cover),
                                  ),
                                );
                              },
                              itemCount: _longVideo!.length,
                            ),
                    )
                  : selectedTab == 1
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "98/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "88/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "85/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "30/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "29/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "10/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "11/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "12/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "13/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "14/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "15/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "16/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "17/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "18/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "19/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "20/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "25/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "26/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "24/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "31/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "50/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "56/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "57/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "30/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "29/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "10/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "11/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "12/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "13/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "14/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "15/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "16/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "17/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "18/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "19/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "20/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "25/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "26/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "24/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "31/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
            ],
          ),
        ),
      ),
      floatingActionButton: VxCircle(
        child: (Icon(
          Icons.add,
          color: Vx.white,
        )),
        radius: 50,
        backgroundColor: Vx.lightBlue400,
      ),
      bottomNavigationBar: bottomBar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
