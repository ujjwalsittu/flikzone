import 'package:flickzone/constants.dart';
import 'package:flickzone/screens/SingleLongVideo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:u2flutter_player/u2flutter_player.dart';
import 'package:velocity_x/src/extensions/date_time_ext.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';
import 'package:velocity_x/velocity_x.dart';

class LongVideoCard extends StatefulWidget {
  String title;
  String hastag;
  String location;
  String createdOn;
  String thumbnailUrl;
  String videoUrl;
  int noOfDislikes;
  int noOfLikes;
  int noOfComment;
  String username;
  int noOfView;
  String profilePic;
  int id;

  LongVideoCard(
      {required this.id,
      required this.username,
      required this.profilePic,
      required this.thumbnailUrl,
      required this.createdOn,
      required this.title,
      required this.hastag,
      required this.location,
      required this.noOfView,
      required this.noOfComment,
      required this.noOfDislikes,
      required this.noOfLikes,
      required this.videoUrl});

  @override
  State<LongVideoCard> createState() => _LongVideoCardState();
}

class _LongVideoCardState extends State<LongVideoCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          child: Image.network(
            widget.thumbnailUrl,
            fit: BoxFit.cover,
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(12, 12, 16, 15),
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.profilePic),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3),
                    child: Text(
                      widget.username +
                          " | Posted " +
                          DateTime.parse(widget.createdOn.toString())
                              .timeAgo(enableFromNow: true, useShortForm: false)
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
    );
  }
}
