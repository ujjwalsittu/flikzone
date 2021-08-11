import 'package:flickzone/screens/SingleLongVideo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/src/extensions/date_time_ext.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class LongVideoCard extends StatelessWidget {
  String descrition;
  String hastag;
  String location;
  String createdOn;
  String thumbnailUrl;
  String videoUrl;
  int noOfDislikes;
  int noOfLikes;
  int noOfComment;
  String username;
  String profilePic;
  int id;

  LongVideoCard(
      {required this.id,
      required this.username,
      required this.profilePic,
      required this.thumbnailUrl,
      required this.createdOn,
      required this.descrition,
      required this.hastag,
      required this.location,
      required this.noOfComment,
      required this.noOfDislikes,
      required this.noOfLikes,
      required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          child: Image.network(
            thumbnailUrl,
            fit: BoxFit.cover,
          ),
          width: double.infinity,
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(12, 12, 16, 15),
              child: CircleAvatar(
                backgroundImage: NetworkImage(profilePic),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    descrition,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3),
                    child: Text(
                      username +
                          " " +
                          DateTime.parse(createdOn.toString())
                              .timeAgo(enableFromNow: true, useShortForm: false)
                              .firstLetterUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
