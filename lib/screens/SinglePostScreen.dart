import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flickzone/constants.dart';
import 'package:flickzone/models/singlePostModel.dart';
import 'package:flickzone/screens/LVCommentScreen.dart';
import 'package:flickzone/screens/profile.dart';
import 'package:flickzone/services/SinglePostServices.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:velocity_x/velocity_x.dart';

class SinglePostScreen extends StatefulWidget {
  final int id;
  final int userid;
  SinglePostScreen({required this.id, required this.userid});

  @override
  _SinglePostScreenState createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  @override
  void initState() {
    getPostData();
    profileDetails();
  }

  bool isLoading = true;

  List<SinglePostModels> _singlePost = <SinglePostModels>[];
  void getPostData() async {
    final resp = await SinglePostService().loadPostData(widget.id);
    if (resp.isNotEmpty) {
      setState(() {
        _singlePost = resp;
        isLoading = false;
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
    var url = Uri.http(kAppUrlHalf, 'user/${widget.userid}');
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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("Post"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                AppBar(
                  leading: Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0, 5),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(profilePic),
                    ),
                  ),
                  backgroundColor: Vx.white,
                  foregroundColor: Vx.black,
                  elevation: 3,
                  title: Text(
                    fullName,
                    style: TextStyle(fontSize: 15),
                  ),
                  centerTitle: false,
                  actions: [
                    widget.userid == _singlePost[0].userId
                        ? GestureDetector(
                            onTap: () {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.confirm,
                                  title: "You Want To Delete This Post",
                                  confirmBtnText: "Sure",
                                  onConfirmBtnTap: () async {
                                    var url = Uri.http(kAppUrlHalf,
                                        'post/delete/${widget.id}');
                                    var response = await http.delete(url);
                                    profileResp = jsonDecode(response.body);
                                    Navigator.popAndPushNamed(
                                        context, kProfileScreen);
                                  },
                                  onCancelBtnTap: () {
                                    Navigator.of(context).pop();
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.delete),
                            ))
                        : SizedBox()
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Container(
                      child: Row(
                    children: <Widget>[
                      Flexible(
                        child: new Text(
                          _singlePost[0].postContent.firstLetterUpperCase(),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  )),
                ),
                _singlePost[0].hasImage == 1
                    ? Flexible(
                        fit: FlexFit.loose,
                        child: new Image.network(
                          kVideoUrl + _singlePost[0].postImage.toString(),
                          fit: BoxFit.cover,
                        ),
                      )
                    : SizedBox(
                        height: 1,
                      ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      FaIcon(
                        Icons.favorite,
                        color: Vx.red500,
                      ),
                      // _singlePost[0].isLike == 1
                      //     ? Text(
                      //         "You and ${_posts![index].noOfLikes.toString()} other people liked this")
                      Text("  people liked this"),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
                  child: Text(
                      DateTime.parse(_singlePost[0].createdOn.toString())
                          .timeAgo(enableFromNow: true, useShortForm: false)
                          .firstLetterUpperCase(),
                      style: TextStyle(color: Colors.grey)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // ignore: unnecessary_new
                      new IconButton(
                        icon:
                            // _posts![index].isLike == 1
                            // // ignore: prefer_const_constructors
                            //     ? FaIcon(
                            //   Icons.favorite,
                            //   color: Vx.red500,
                            // )
                            // // ignore: prefer_const_constructors
                            //     :
                            FaIcon(
                          Icons.favorite_border,
                          color: Vx.gray500,
                        ),
                        onPressed: () {
                          var box = Hive.box('OTP');
                          int myidd = box.get('userid');
                          String contentId = _singlePost[0].id.toString();

                          // if (_posts![index].isLike == 1) {
                          //   final url = kAppUrl +
                          //       "/likesanddislikes/delete/" +
                          //       contentId +
                          //       "/" +
                          //       myid.toString();
                          //   setState(() {
                          //     _posts![index].isLike = 0;
                          //   });
                          //   print(url);
                          //   Dio().delete(url);
                          // } else {
                          //   sendLike(_myid, 1, contentId, index);
                          // }
                        },
                      ),
                      // ignore: unnecessary_new
                      new SizedBox(
                        child: "|".text.make(),
                        width: 16.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (_) => LVComment(
                                  "0", _singlePost[0].id.toString(), "0"),
                            ),
                          );
                        },
                        child: const Icon(
                          FontAwesomeIcons.comment,
                        ),
                      ),
                      // ignore: unnecessary_new
                      new SizedBox(
                        child: "|".text.make(),
                        width: 16.0,
                      ),
                      // ignore: unnecessary_new
                      new VxContinuousRectangle(
                        height: 40,
                        width: 50,
                        backgroundColor: Vx.white,
                        // ignore: prefer_const_constructors
                        backgroundImage: DecorationImage(
                          // ignore: prefer_const_constructors
                          image: AssetImage("assets/images/flick.png"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
