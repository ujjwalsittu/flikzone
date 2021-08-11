import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:dio/dio.dart';
import 'package:flickzone/constants.dart';
import 'package:flickzone/models/ShortVideo.dart';
import 'package:flickzone/models/commentModel.dart';
import 'package:flickzone/screens/ShortVideoScreen.dart';
import 'package:flickzone/widgets/CommentWebServices.dart';
import 'package:flickzone/widgets/ShortVideoWebServices.dart';
import 'package:flickzone/widgets/VideoPlayer.dart';
import 'package:flickzone/widgets/left_items.dart';
import 'package:flickzone/widgets/right_items.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:velocity_x/src/extensions/date_time_ext.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class ShortFlik extends StatefulWidget {
  const ShortFlik({Key? key}) : super(key: key);

  @override
  _ShortFlikState createState() => _ShortFlikState();
}

class _ShortFlikState extends State<ShortFlik> {
  TextEditingController _textController = TextEditingController();

  List<ShortVideo> tiktuk = <ShortVideo>[];

  Color fav = Colors.white;

  void loadShortVideos() async {
    final resp = await ShortVideoWebService().loadAllLV();
    if (resp.isNotEmpty) {
      setState(() {
        tiktuk = resp;
      });
    } else {
      tiktuk = tiktuk;
    }
    print("Executed");
    print(tiktuk.length);
  }

  @override
  void initState() {
    super.initState();
    loadShortVideos();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    loadShortVideos();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TikTokStyleFullPageScroller(
        contentSize: tiktuk.length,
        swipePositionThreshold: 0.2,
        // swipeThreshold: 0.2,
        // ^ the fraction of the screen needed to scroll
        swipeVelocityThreshold: 2000,
        // ^ the velocity threshold for smaller scrolls
        animationDuration: const Duration(milliseconds: 300),
        // ^ how long the animation will take
        builder: (BuildContext context, index) {
          return tiktuk.length == 0
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Stack(
                  children: <Widget>[
                    TikTokVideoPlayer(url: kImageUrl + tiktuk[index].videoUrl),
                    title(),
                    // RightItems(
                    //   comments: ,
                    //   userImg: kImageUrl + tiktuk[index].musicThumbNailUrl,
                    //   coverImg: ,
                    //   noOfLikes: tiktuk[index].noOfLikes.toString(),
                    // ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(kImageUrl +
                                    tiktuk[index].musicThumbNailUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          GestureDetector(
                            onTap: () {
                              var box = Hive.box('OTP');
                              int myid = box.get("userid");
                              FormData formData = FormData.fromMap({
                                "userID": myid,
                                "isPostLike": 1,
                                "contentId": tiktuk[index].id
                              });
                              try {
                                var response = Dio().post(
                                    "http://15.207.105.12:4040/likesanddislikes/upload",
                                    data: formData);
                                // print(response!.data);
                                print("Likes Working");
                              } on DioError catch (e) {
                                print(e.response!.statusCode);
                              }
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.favorite,
                                    color: fav == Colors.white
                                        ? Colors.red
                                        : Colors.white,
                                    size: 40.0),
                                SizedBox(height: 5.0),
                                Text(
                                  tiktuk[index].noOfLikes.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 10.0)
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              String _comment;
                              List<CommentModel> _comments = <CommentModel>[];
                              final resp = await CommentWebServices()
                                  .loadComment(tiktuk[index].id);
                              setState(() {
                                _comments = resp;
                              });
                              showStickyFlexibleBottomSheet(
                                context: context,
                                headerBuilder:
                                    (BuildContext context, double offset) {
                                  return Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: new TextField(
                                            onChanged: (value) {
                                              setState(() {
                                                _comment = value;
                                              });
                                            },
                                            controller: _textController,
                                            decoration: new InputDecoration(
                                              border: InputBorder.none,
                                              enabled: true,
                                              hintText: "Add a comment...",
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.send),
                                      ],
                                    ),
                                  );
                                },
                                builder: ((BuildContext context, index) {
                                  return SliverChildListDelegate([
                                    ListView.builder(
                                        itemCount: _comments.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: Image.network(kDefaultPic),
                                            title:
                                                Text(_comments[index].content),
                                            subtitle: Text(
                                              DateTime.parse(_comments[index]
                                                      .createdOn
                                                      .toString())
                                                  .timeAgo(
                                                      enableFromNow: true,
                                                      useShortForm: false)
                                                  .firstLetterUpperCase(),
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          );
                                        }),
                                  ]);
                                }),
                              );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.comment,
                                    color: Colors.white, size: 40.0),
                                SizedBox(height: 5.0),
                                Text(
                                  tiktuk[index].noOfLikes.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 10.0)
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/flick.png",
                                  color: Colors.white,
                                  scale: 2,
                                ),
                                SizedBox(height: 5.0),
                                SizedBox(height: 10.0)
                              ],
                            ),
                          ),
                          SizedBox(height: 40.0),
                          Container(
                            height: 60.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: AvatarGlow(
                              glowColor: Colors.black,
                              endRadius: 35.0,
                              child: Container(
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(kImageUrl +
                                          tiktuk[index]
                                              .musicThumbNailUrl
                                              .toString()),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    LeftItems(
                      description: tiktuk[index].descrition,
                      musicName: tiktuk[index].musicId.toString(),
                      authorName: tiktuk[index].userId.toString(),
                      userName: tiktuk[index].userId.toString(),
                    )
                  ],
                );
        },
      ),
    );
  }

  Widget title() => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 28.0),
          child: Text(
            "For You",
            style: TextStyle(
              color: Colors.white,
              fontSize: 19.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
