import 'dart:convert';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flickzone/constants.dart';
import 'package:flickzone/widgets/LongVideoWebService.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/src/extensions/date_time_ext.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:flickzone/models/LongVideos.dart';
import 'package:visibility_detector/visibility_detector.dart';

String kSingleLong = '/slv';

class SingleLongVideo extends StatefulWidget {
  final String url;
  final int id;
  final int userid;
  const SingleLongVideo(
      {required this.url, required this.id, required this.userid});
  @override
  _SingleLongVideoState createState() => _SingleLongVideoState();
}

class _SingleLongVideoState extends State<SingleLongVideo> {
  bool isLoading = true;
  List<LongVideo>? _longVid = <LongVideo>[];
  List<LongVideo>? _allLongVideos = <LongVideo>[];

  late VideoPlayerController _controller;
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.network('${kImageUrl + widget.url}'),
    );
    // Future.delayed(Duration(seconds: 2));
    profileDetails(widget.userid);
    _loadVideoData();
    _allLongVideo();
    getFollowedStatus();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  void _loadVideoData() async {
    final resp = await LongVideoWebService().loadLVById(widget.id);
    if (resp.length != 0) {
      setState(() {
        _longVid = resp;
        isLoading = false;
        print("FETCHED LENGTH");
        print(_longVid?.length);
      });
    }
  }

  void _allLongVideo() async {
    final resp = await LongVideoWebService().loadAllLV();
    if (resp.length != 0) {
      setState(() {
        _allLongVideos = resp.cast<LongVideo>();
        isLoading = false;
        print(_allLongVideos?.length);
      });
    }
  }

  late dynamic profileResp;

  String fullName = "Full Name";
  String profilePic = kDefaultPic;
  String username = "Username";
  bool isFollowed = false;
  int totalFollowers = 0;
  void profileDetails(int useriD) async {
    var url = Uri.http("15.207.105.12:4040", 'user/$useriD');
    var response = await http.get(url);
    profileResp = jsonDecode(response.body);
    setState(() {
      fullName = profileResp['data'][0]['fullName'];
      profilePic = profileResp['data'][0]['profilepic'];

      username = profileResp['data'][0]['username'];
      totalFollowers = profileResp['data'][0]['totalFollowers'];
    });
  }

  late int followedID;
  late int myid;
  void getFollowedStatus() async {
    var box = Hive.box('OTP');
    int useri = box.get('userid');
    var url = Uri.http("15.207.105.12:4040", 'follow/user/$useri');
    var response = await http.get(url);
    profileResp = jsonDecode(response.body);
    followedID = profileResp['data'][0]['followedUID'];
    if (followedID == widget.userid) {
      setState(() {
        myid = useri;
        isFollowed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickManager.flickControlManager?.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickManager.flickControlManager?.autoResume();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    child: FlickVideoPlayer(
                      flickManager: flickManager,
                      flickVideoWithControls: FlickVideoWithControls(
                        controls: FlickPortraitControls(),
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        _longVid![0].descrition,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: [
                          // Text(_longVid![0].noOfViews),
                          Text(
                            DateTime.parse(_longVid![0].createdOn.toString())
                                .timeAgo(
                                    enableFromNow: true, useShortForm: false)
                                .firstLetterUpperCase(),
                            style: TextStyle(color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.favorite_border),
                        Icon(Icons.comment),
                        Image.asset(
                          'assets/images/flick.png',
                          scale: 3,
                        ),
                        Icon(Icons.menu),
                        Icon(Icons.menu),
                        // Icon(Icons.favorite_border),
                      ],
                    ),
                  ),
                  Container(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(profilePic.isEmptyOrNull
                            ? kDefaultPic
                            : profilePic),
                      ),
                      title: Text(fullName),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(totalFollowers.toString() + " Followers"),
                          isFollowed
                              ? GestureDetector(
                                  onTap: () async {
                                    String url = kAppUrl +
                                        "/follow/delete/" +
                                        myid.toString() +
                                        widget.userid.toString();
                                    var resp =
                                        await http.delete(Uri.parse(url));
                                    if (resp.statusCode == 200) {
                                      VxToast.show(context, msg: "UnFollowed");
                                    }
                                  },
                                  child: Text(
                                    "Following",
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    String url = kAppUrl +
                                        "/follow/delete/" +
                                        myid.toString() +
                                        widget.userid.toString();
                                    var resp =
                                        await http.delete(Uri.parse(url));
                                    if (resp.statusCode == 200) {
                                      VxToast.show(context, msg: "UnFollowed");
                                    }
                                  },
                                  child: Text(
                                    "Follow",
                                    style: TextStyle(color: Colors.blueGrey),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomBar(),
      // floatingActionButton: FloatingBar(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
