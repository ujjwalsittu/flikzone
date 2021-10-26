import 'dart:io';

import 'package:flickzone/constants.dart';
import 'package:flickzone/helpers/flick_multi_manager.dart';
import 'package:flickzone/helpers/flick_multi_player.dart';
import 'package:flickzone/models/LongVideos.dart';
import 'package:flickzone/models/videCategoryModel.dart';
import 'package:flickzone/screens/SingleLongVideo.dart';
import 'package:flickzone/widgets/LongVideoCards.dart';
import 'package:flickzone/widgets/LongVideoWebService.dart';
import 'package:flickzone/widgets/appBar.dart';
import 'package:flickzone/widgets/floatingBar.dart';
import 'package:flickzone/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:velocity_x/src/extensions/date_time_ext.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';
import 'package:visibility_detector/visibility_detector.dart';

String kVideoScreen = "/videoscreen";

class LongVidByCat extends StatefulWidget {
  int id;
  String catName;
  LongVidByCat({required this.id, required this.catName});

  @override
  _LongVidByCatState createState() => _LongVidByCatState();
}

class _LongVidByCatState extends State<LongVidByCat> {
  bool isLoading = true;
  late FlickMultiManager flickMultiManager;

  List<LongVideoByCatModel>? _longVideos = <LongVideoByCatModel>[];
  void initState() {
    super.initState();
    _loadLongVideo();
    flickMultiManager = FlickMultiManager();
  }

  void _loadLongVideo() async {
    final resp = await LongVideoWebService().allLvById(widget.id);
    if (resp.length != 0) {
      setState(() {
        _longVideos = resp;
        isLoading = false;
        print(_longVideos?.length);
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
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text(widget.catName),
      ),
      body: Stack(
        children: [
          _longVideos!.length == 0
              ? Center(
                  child: Text("No Videos Under This Category"),
                )
              : isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _longVideos!.length,
                      itemBuilder: (context, index) => VisibilityDetector(
                        key: ObjectKey(flickMultiManager),
                        onVisibilityChanged: (visibility) {
                          if (visibility.visibleFraction == 0 && this.mounted) {
                            flickMultiManager.pause();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: GestureDetector(
                            onTap: () {
                              playVideo(
                                  _longVideos![index].videoUrl,
                                  _longVideos![index].id,
                                  _longVideos![index].userId);
                            },
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
                                            _longVideos![index].profilepic),
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
        ],
      ),

      // floatingActionButton: FloatingBar(),
      // // VxCircle(
      // //   child: GestureDetector(
      // //     onTap: () {
      // //       // Navigator.push(context,
      // //       //     MaterialPageRoute(builder: (context) => VideoScreen()));
      // //     },
      // //     child: (Icon(
      // //       Icons.add,
      // //       color: Vx.white,
      // //     )),
      // //   ),
      // //   radius: 50,
      // //   backgroundColor: Vx.lightBlue400,
      // // ),
      // bottomNavigationBar: bottomBar(),
      // // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
