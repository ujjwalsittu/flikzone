import 'dart:io';

import 'package:flickzone/constants.dart';
import 'package:flickzone/helpers/flick_multi_manager.dart';
import 'package:flickzone/helpers/flick_multi_player.dart';
import 'package:flickzone/models/LongVideos.dart';
import 'package:flickzone/models/videCategoryModel.dart';
import 'package:flickzone/screens/LongVideoScreenByCat.dart';
import 'package:flickzone/screens/SingleLongVideo.dart';
import 'package:flickzone/widgets/LongVideoCards.dart';
import 'package:flickzone/widgets/LongVideoWebService.dart';
import 'package:flickzone/widgets/appBar.dart';
import 'package:flickzone/widgets/floatingBar.dart';
import 'package:flickzone/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:visibility_detector/visibility_detector.dart';

String kVideoScreen = "/videoscreen";

class LongVideoScreen extends StatefulWidget {
  @override
  _LongVideoScreenState createState() => _LongVideoScreenState();
}

class _LongVideoScreenState extends State<LongVideoScreen> {
  bool isLoading = true;
  List<LongVideo>? _longVideos = <LongVideo>[];
  List<VideoCategoryModel>? _videoCat = <VideoCategoryModel>[];
  late FlickMultiManager flickMultiManager;

  void initState() {
    super.initState();
    _loadLongVideo();
    _loadVideoCat();
    flickMultiManager = FlickMultiManager();
  }

  void _loadLongVideo() async {
    final resp = await LongVideoWebService().loadAllLV();
    if (resp.length != 0) {
      setState(() {
        _longVideos = resp;
        isLoading = false;
        print(_longVideos?.length);
      });
    }
  }

  void _loadVideoCat() async {
    final resp = await LongVideoWebService().loadVideCat();
    if (resp.length != 0) {
      setState(() {
        _videoCat = resp;
        print("${_videoCat!.length} is  video cat length");
      });
    }
  }

  playVideo(String vurl, int id, int useriD) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (_) => SingleLongVideo(
                  url: vurl,
                  id: id,
                  userid: useriD,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 45,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _videoCat!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              color: Colors.black45,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (_) => LongVidByCat(
                                                  id: _videoCat![index].id,
                                                  catName:
                                                      _videoCat![index].name,
                                                )));
                                  },
                                  child: Text(
                                    _videoCat![index].name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _longVideos!.length,
                    itemBuilder: (context, index) => VisibilityDetector(
                      key: ObjectKey(flickMultiManager),
                      onVisibilityChanged: (visibility) {
                        if (visibility.visibleFraction == 0 && this.mounted) {
                          flickMultiManager.pause();
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          playVideo(
                              _longVideos![index].videoUrl,
                              _longVideos![index].id,
                              _longVideos![index].userId);
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: FlickMultiPlayer(
                                      id: _longVideos![index].id,
                                      userid: _longVideos![index].userId,
                                      url: kVideoUrl +
                                          _longVideos![index].videoUrl,
                                      flickMultiManager: flickMultiManager,
                                      image: kVideoUrl +
                                          _longVideos![index].thumbnailUrl,
                                    ),
                                  ),

                                  // child: Image.network(
                                  //   kImageUrl + _longVideos![index].thumbnailUrl,
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(12, 12, 16, 15),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            _longVideos![index].userPic),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _longVideos![index].title,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 3),
                                            child: Text(
                                              _longVideos![index].username +
                                                  " | Posted " +
                                                  DateTime.parse(
                                                          _longVideos![index]
                                                              .createdOn
                                                              .toString())
                                                      .timeAgo(
                                                          enableFromNow: true,
                                                          useShortForm: false)
                                                      .firstLetterUpperCase(),
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.black45,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // IconButton(
                                    //   icon: Icon(Icons.more_vert),
                                    //   onPressed: () {},
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
                color: Color.fromRGBO(0, 179, 134, 1.0),
              ),
              DialogButton(
                child: Text(
                  "ShortFlik",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () {
                  // if (Platform.isAndroid) {
                  //   _startVideoEditorActivity();
                  // } else if (Platform.isIOS) {
                  //   _startIOSVideoEditorActivity();
                  // } else {
                  //   _showAlert(context, "Platform is not supported!");
                  // }
                  VxToast.show(context, msg: "Under Development");
                },
                gradient: LinearGradient(colors: [
                  Color.fromARGB(116, 116, 191, 1),
                  Color.fromRGBO(52, 138, 199, 1.0)
                ]),
              ),
              DialogButton(
                child: Text(
                  "PostFlik",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/postcreate");
                },
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(116, 116, 191, 1.0),
                  Color.fromRGBO(52, 138, 199, 1.0)
                ]),
              ),
            ],
          ).show();
        },
        child: Icon(Icons.add),
      ),
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
