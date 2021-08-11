import 'package:flickzone/constants.dart';
import 'package:flickzone/models/LongVideos.dart';
import 'package:flickzone/screens/SingleLongVideo.dart';
import 'package:flickzone/widgets/LongVideoCards.dart';
import 'package:flickzone/widgets/LongVideoWebService.dart';
import 'package:flickzone/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

String kVideoScreen = "/videoscreen";

class LongVideoScreen extends StatefulWidget {
  @override
  _LongVideoScreenState createState() => _LongVideoScreenState();
}

class _LongVideoScreenState extends State<LongVideoScreen> {
  bool isLoading = true;
  List<LongVideo>? _longVideos = <LongVideo>[];
  void initState() {
    super.initState();
    _loadLongVideo();
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
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: _longVideos!.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(3.0),
                child: GestureDetector(
                  onTap: () {
                    playVideo(_longVideos![index].videoUrl,
                        _longVideos![index].id, _longVideos![index].userId);
                  },
                  child: LongVideoCard(
                      id: _longVideos![index].id,
                      username: "username",
                      profilePic: kDefaultPic,
                      // thumbnailUrl: _longVideos![index].thumbnailUrl,
                      thumbnailUrl:
                          kImageUrl + _longVideos![index].thumbnailUrl,
                      createdOn: _longVideos![index].createdOn,
                      descrition: _longVideos![index].descrition,
                      hastag: _longVideos![index].hasTags,
                      location: _longVideos![index].location,
                      noOfComment: _longVideos![index].noOfComment,
                      noOfDislikes: _longVideos![index].noOfDislikes,
                      noOfLikes: _longVideos![index].noOfLikes,
                      videoUrl: _longVideos![index].videoUrl),
                ),
              ),
            ),
    );
  }
}
