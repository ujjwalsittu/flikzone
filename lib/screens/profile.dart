import 'dart:convert';

import 'package:flickzone/constants.dart';
import 'package:flickzone/models/ShortVideo.dart';
import 'package:flickzone/models/postModel.dart';
import 'package:flickzone/screens/SingleLongVideo.dart';
import 'package:flickzone/screens/SinglePostScreen.dart';
import 'package:flickzone/screens/homescreen.dart';
import 'package:flickzone/screens/notifications.dart';
import 'package:flickzone/screens/search.dart';
import 'package:flickzone/widgets/LongVideoWebService.dart';
import 'package:flickzone/widgets/ShortVideoWebServices.dart';
import 'package:flickzone/widgets/navbar.dart';
import 'package:flickzone/widgets/postWebServ.dart';
import 'package:flutter/cupertino.dart';
import 'package:flickzone/models/LongVideos.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
// import 'package:quds_ui_kit/quds_ui_kit.dart';

String kProfileScreen = "/profile";

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool noLV = true;
  bool noPost = true;
  bool noSV = true;
  List<LongVideoByUID>? _longVideo = <LongVideoByUID>[];
  List<PostOfUser>? _allPosts = <PostOfUser>[];
  List<ShortVideo>? _allShortVideo = <ShortVideo>[];
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
    final lvResults = await LongVideoWebService().loadLVByUId(userid);
    final postResults = await PostWebServices().loadUserPost(userid);
    final shortResults = await ShortVideoWebService().loadLV(userid);
    print(lvResults.length);
    if (lvResults.isNotEmpty) {
      setState(() {
        noLV = false;
        _longVideo = lvResults;
        print(_longVideo);
        print("ENTERED THIS BLOCK");
      });
    }
    if (postResults.isNotEmpty) {
      setState(() {
        noPost = false;
        _allPosts = postResults;
      });
    }
    if (shortResults.isNotEmpty) {
      setState(() {
        noSV = false;
        _allShortVideo = shortResults;
      });
    }
  }

  int selectedTab = 0;
  late String resp;
  int uid = 0;
  String fullName = "Full Name";
  String profilePic = kDefaultPic;
  String username = "Username";
  int noOfPost = 0;
  int totalFollowers = 0;
  int totalpost = 0;
  int verified = 0;
  int totalVideos = 0;
  late dynamic profileResp;
  var box = Hive.box('OTP');
  void profileDetails() async {
    int userid = box.get("userid");
    uid = userid;
    var url = Uri.http(kAppUrlHalf, 'user/$userid');
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
      verified = profileResp['data'][0]['verificationStatus'];
      // print(noOfPost);
      totalFollowers = profileResp['data'][0]['totalFollowers'];
    });
  }

  // List<QudsPopupMenuBase> getMenuItems() {
  //   return [
  //     QudsPopupMenuSection(
  //         backgroundColor: Colors.white,
  //         titleText: fullName,
  //         subTitle: Text('Profile Options Here'),
  //         leading: Icon(
  //           Icons.account_box_outlined,
  //           size: 40,
  //         ),
  //         subItems: [
  //           QudsPopupMenuItem(
  //               leading: Icon(Icons.logout),
  //               title: Text('Update Profile'),
  //               onPressed: () {
  //                 Navigator.pushNamed(context, "/updateProfile");
  //               }),
  //           QudsPopupMenuItem(
  //               leading: Icon(Icons.logout),
  //               title: Text('Logout'),
  //               onPressed: () {
  //                 // showToast('Logout Pressed!');
  //               })
  //         ])
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: GFDrawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GFDrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.grey, Colors.black54],
                      tileMode: TileMode.mirror)),
              currentAccountPicture: GFAvatar(
                radius: 80.0,
                backgroundImage: NetworkImage(profilePic),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(fullName),
                  Text(username),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle_outlined),
              title: Text('Update Profile'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/updateProfile');
              },
            ),
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Request Verification'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: fullName.text.white.make(),
        iconTheme: IconThemeData(color: Vx.white),
        actionsIconTheme: IconThemeData(color: Vx.white),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back),
        ),
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
                    Row(
                      children: [
                        username.text.xl2.gray500.bold.make(),
                        SizedBox(
                          width: 10,
                        ),
                        verified == 1
                            ? Icon(
                                Icons.verified,
                                color: Colors.blue,
                              )
                            : "".text.make()
                      ],
                    ),
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
              SizedBox(
                height: 10,
              ),
              selectedTab == 0
                  ? Container(
                      child: noPost
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("NO POST FOUND"),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4),
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (_) => SinglePostScreen(
                                              id: _allPosts![index].id,
                                              userid: uid)),
                                    );
                                  },
                                  child: _allPosts![index].postVideo == "0" &&
                                          _allPosts![index].postImage == "0"
                                      ? Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: CircleAvatar(
                                            child: Text("Text Post"),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: VxContinuousRectangle(
                                            radius: 40,
                                            height: 150,
                                            width: 80,
                                            backgroundImage: DecorationImage(
                                                image: _allPosts![index]
                                                            .postVideo ==
                                                        "0"
                                                    ? NetworkImage(
                                                        (kImageUrl +
                                                            _allPosts![index]
                                                                .postImage),
                                                      )
                                                    : NetworkImage(
                                                        (kImageUrl +
                                                            _allPosts![index]
                                                                .postVideo),
                                                      ),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                );
                              },
                              itemCount: _allPosts!.length,
                            ),
                    )
                  : selectedTab == 1
                      ? Container(
                          child: noSV
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("NO SHORT VIDEO FOUND"),
                                  ),
                                )
                              : GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4),
                                  itemBuilder: (BuildContext ctx, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        //TODO : ShortVideo Screen
                                        // Navigator.push(
                                        //   context,
                                        //   new MaterialPageRoute(
                                        //       builder: (_) => SinglePostScreen(
                                        //           id: _allShortVideo![index].id,
                                        //           userid: uid)),
                                        // );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: VxContinuousRectangle(
                                          radius: 40,
                                          height: 150,
                                          width: 80,
                                          backgroundImage: DecorationImage(
                                              image: NetworkImage((kImageUrl +
                                                  _allShortVideo![index]
                                                      .thumbnailUrl)),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: _allShortVideo!.length,
                                ),
                        )
                      : Container(
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
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (_) => SingleLongVideo(
                                                      url: _longVideo![index]
                                                          .videoUrl,
                                                      id: _longVideo![index].id,
                                                      userid: uid,
                                                    )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: VxContinuousRectangle(
                                          radius: 40,
                                          height: 150,
                                          width: 80,
                                          backgroundImage: DecorationImage(
                                              image: NetworkImage((kImageUrl +
                                                  _longVideo![index]
                                                      .thumbnailUrl)),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: _longVideo!.length,
                                ),
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
                onTap: () {
                  Navigator.pushNamed(context, kHomeRoute);
                },
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
                  // Navigator.pushNamed(context, kProfileScreen);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
