import 'package:flickzone/models/ShortVideo.dart';
import 'package:flickzone/widgets/VideoPlayer.dart';
import 'package:flickzone/widgets/left_items.dart';
import 'package:flickzone/widgets/right_items.dart';
import 'package:flutter/material.dart';

class TikTokVideo extends StatelessWidget {
  final ShortVideo data;

  const TikTokVideo({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TikTokVideoPlayer(url: data.videoUrl[0]),
          title(),
          // RightItems(
          //   comments: data.noOfComment.toString(),
          //   userImg: data.musicThumbNailUrl[0],
          //   coverImg: data.musicThumbNailUrl,
          //   noOfLikes: data.noOfLikes.toString(),
          // ),
          LeftItems(
            description: data.descrition,
            musicName: data.musicId.toString(),
            authorName: data.userId.toString(),
            userName: data.userId.toString(),
          )
        ],
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
