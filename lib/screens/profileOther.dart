import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flickzone/constants.dart';
import 'package:flickzone/models/LongVideos.dart';
import 'package:flickzone/models/ShortVideo.dart';
import 'package:flickzone/models/postModel.dart';
import 'package:flickzone/screens/SingleLongVideo.dart';
import 'package:flickzone/screens/SinglePostScreen.dart';
import 'package:flickzone/screens/homescreen.dart';
import 'package:flickzone/screens/messages.dart';
import 'package:flickzone/widgets/LongVideoWebService.dart';
import 'package:flickzone/widgets/ShortVideoWebServices.dart';
import 'package:flickzone/widgets/navbar.dart';
import 'package:flickzone/widgets/postWebServ.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

String kOtherProfile = "/kOtherProfile";

class OtherProfile extends StatefulWidget {
  int userid;
  OtherProfile({required this.userid});
  @override
  State<OtherProfile> createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  bool iFollow = false;
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
    getFollowedStatus();
    profileDetails();
    _loadLV();
  }

  String followText = "Follow";
  bool isFollowed = false;
  late int followedID;
  late int myid;

  void getFollowedStatus() async {
    var box = Hive.box('OTP');
    int useri = box.get('userid');
    myid = box.get('userid');
    var url = Uri.http(kAppUrlHalf, 'follow/${widget.userid}/$myid');
    var response = await http.get(url);
    profileResp = jsonDecode(response.body);
    followedID = profileResp['data'][0]['isFollow'];
    if (followedID == 1) {
      setState(() {
        myid = useri;
        followText = "Following";
        isFollowed = true;
      });
    }
  }

  void _loadLV() async {
    // var box = Hive.box('OTP');
    // int userid = box.get('userid');
    final lvResults = await LongVideoWebService().loadLVByUId(widget.userid);
    final postResults = await PostWebServices().loadUserPost(widget.userid);
    final shortResults = await ShortVideoWebService().loadLV(widget.userid);
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
  int verified = 0;
  int totalpost = 0;
  int totalVideos = 0;
  late dynamic profileResp;
  var box = Hive.box('OTP');
  void profileDetails() async {
    uid = box.get('userid');
    var url = Uri.http("3.109.150.228:4040", 'user/${widget.userid}');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: fullName.text.white.make(),
        iconTheme: IconThemeData(color: Vx.white),
        leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, kHomeRoute);
            },
            child: Icon(Icons.arrow_back)),
        actionsIconTheme: IconThemeData(color: Vx.white),
        centerTitle: true,
        actions: [],
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
              myid == widget.userid
                  ? Text("")
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              isFollowed ? Vx.gray300 : Vx.gray700),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                              TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                        onPressed: () {
                          if (isFollowed == true) {
                            Uri url = Uri.parse(kAppUrl +
                                "/" +
                                myid.toString() +
                                "/" +
                                widget.userid.toString());
                            setState(() {
                              isFollowed = false;
                            });
                            print(url);
                            // final resp = http.delete(url);
                          } else {
                            FormData formdata = FormData.fromMap(
                                {'userId': myid, 'followedUID': widget.userid});
                            final resp = Dio().post(kAppUrl + "/follow/upload",
                                data: formdata);
                            setState(() {
                              isFollowed = false;
                            });
                            resp.whenComplete(() => print("done"));
                          }
                        },
                        child: Text(isFollowed ? "Following" : "Follow"),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 5),
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: VxContinuousRectangle(
                                      radius: 40,
                                      height: 150,
                                      width: 80,
                                      backgroundImage: DecorationImage(
                                          image: NetworkImage((kImageUrl +
                                              _allPosts![index].postImage)),
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
      bottomNavigationBar: bottomBar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
