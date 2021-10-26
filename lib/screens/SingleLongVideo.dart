import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flickzone/constants.dart';
import 'package:flickzone/models/commentModel.dart';
import 'package:flickzone/screens/LVCommentScreen.dart';
import 'package:flickzone/widgets/CommentWebServices.dart';
import 'package:flickzone/widgets/LongVideoCards.dart';
import 'package:flickzone/widgets/LongVideoWebService.dart';
import 'package:flickzone/widgets/SingleVideoCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
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
  List<LongVideoByID>? _longVid = <LongVideoByID>[];
  List<LongVideo>? _allLongVideos = <LongVideo>[];
  int isLiked = 0;
  int isDisLiked = 0;

  late VideoPlayerController _controller;
  late FlickManager flickManager;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.url),
      autoPlay: true,
    );
    // Future.delayed(Duration(seconds: 2));
    profileDetails(widget.userid);
    _loadVideoData();
    _allLongVideo();
    getFollowedStatus();
    _loadPath();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    flickManager.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  void _loadVideoData() async {
    var box = Hive.box('OTP');
    int ui = box.get('userid');
    final resp = await LongVideoWebService().loadLVById(widget.id, ui);
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
  String followText = "Follow";
  int totalFollowers = 0;
  void profileDetails(int useriD) async {
    var url = Uri.http("3.109.150.228:4040", 'user/$useriD');
    var response = await http.get(url);
    profileResp = jsonDecode(response.body);
    setState(() {
      fullName = profileResp['data'][0]['fullName'];
      profilePic = profileResp['data'][0]['profilepic'];

      username = profileResp['data'][0]['username'];
      totalFollowers = profileResp['data'][0]['totalFollowers'];
    });
  }

  String dir =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  late String appDocPath;
  String supportDir = "";
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

  void _loadPath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    supportDir = await AndroidPathProvider.downloadsPath;

    setState(() {
      appDocPath = appDocDir.path;
      supportDir = supportDir;
      print(appDocDir);
      print(supportDir);
    });
  }

  playVideo(String vurl, int id, int useriD) {
    Navigator.pop(context);
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
    return SafeArea(
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : VisibilityDetector(
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Container(
                            child: FlickVideoPlayer(
                              flickManager: flickManager,
                              flickVideoWithControls: FlickVideoWithControls(
                                controls: FlickPortraitControls(),
                              ),
                              flickVideoWithControlsFullscreen:
                                  FlickVideoWithControls(
                                controls: FlickLandscapeControls(),
                              ),
                            ),
                          ),
                          Container(
                            // height: 200,
                            width: double.infinity,
                            color: Colors.white,
                            child: ExpandableNotifier(
                              child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(),
                                      ScrollOnExpand(
                                        scrollOnExpand: true,
                                        scrollOnCollapse: true,
                                        child: ExpandablePanel(
                                          theme: const ExpandableThemeData(
                                              headerAlignment:
                                                  ExpandablePanelHeaderAlignment
                                                      .center,
                                              tapBodyToCollapse: true),
                                          header: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              _longVid![0].title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                          ),
                                          collapsed: Text(
                                            dir,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          expanded: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              for (var _
                                                  in Iterable.generate(5))
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10),
                                                    child: Text(
                                                      dir,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.fade,
                                                    )),
                                            ],
                                          ),
                                          builder: (_, collapsed, expanded) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 10),
                                              child: Expandable(
                                                collapsed: collapsed,
                                                expanded: expanded,
                                                theme:
                                                    const ExpandableThemeData(
                                                        crossFadePoint: 0),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            // child: ScrollOnExpand(
                            //   child: ExpandablePanel(
                            //     header: Text(_longVid![0].title),
                            //     collapsed: Text(
                            //       _longVid![0].descrition,
                            //       softWrap: true,
                            //       maxLines: 2,
                            //       overflow: TextOverflow.ellipsis,
                            //     ),
                            //     expanded: Text(
                            //       _longVid![0].descrition,
                            //       softWrap: true,
                            //     ),
                            //   ),
                            // ),
                            // child: ListTile(
                            //   title: Text(
                            //     _longVid![0].title == ""
                            //         ? " Video Title here"
                            //         : _longVid![0].title,
                            //     style: TextStyle(
                            //         fontSize: 17,
                            //         color: Colors.black,
                            //         fontWeight: FontWeight.bold),
                            //   ),
                            //   subtitle: Row(
                            //     children: [
                            //       // Text(_longVid![0].noOfViews),
                            //
                            //       Text(
                            //         DateTime.parse(
                            //                 _longVid![0].createdOn.toString())
                            //             .timeAgo(
                            //                 enableFromNow: true,
                            //                 useShortForm: false)
                            //             .firstLetterUpperCase(),
                            //         style: TextStyle(color: Colors.black87),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ),
                          Container(
                            height: 50,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                isLiked == 1
                                    ? Image.asset(
                                        isLiked == 1
                                            ? 'assets/icons/heart.png'
                                            : 'assets/icons/blank_heart.png',
                                        scale: 1.5,
                                      )
                                    : Image.asset(
                                        'assets/icons/blank_heart.png',
                                        scale: 1.5,
                                      ),

                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    isDisLiked == 1
                                        ? 'assets/icons/blank-broken-heart.png'
                                        : 'assets/icons/blank-broken-heart.png',
                                    scale: 1.5,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                        builder: (_) => LVComment(
                                            "0", widget.id.toString(), "0"),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/icons/comment.png',
                                    scale: 1.5,
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/flick.png',
                                  scale: 3,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final taskId =
                                        await FlutterDownloader.enqueue(
                                      url: kVideoUrl + "/" + widget.url,
                                      savedDir: supportDir,
                                      showNotification:
                                          true, // show download progress in status bar (for Android)
                                      openFileFromNotification:
                                          true, // click on notification to open downloaded file (for Android)
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/icons/download.png',
                                    scale: 1.5,
                                  ),
                                ),
                                // Image.asset(
                                //   'assets/icons/more.png',
                                //   scale: 1.5,
                                // ),

                                // Icon(Icons.favorite_border),
                              ],
                            ),
                          ),
                          Container(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    profilePic.isEmptyOrNull
                                        ? kDefaultPic
                                        : profilePic),
                              ),
                              title: Text(fullName),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      totalFollowers.toString() + " Followers"),
                                  isFollowed == true
                                      ? TextButton(
                                          onPressed: () async {
                                            String url = kAppUrl +
                                                "/follow/delete/" +
                                                myid.toString() +
                                                widget.userid.toString();
                                            if (widget.userid == myid) {
                                              VxToast.show(context,
                                                  msg:
                                                      'You Cannot Unfollow Yourself');
                                            } else {
                                              var resp = await http
                                                  .delete(Uri.parse(url));
                                              if (resp.statusCode == 200) {
                                                VxToast.show(context,
                                                    msg: "UnFollowed");
                                                setState(() {
                                                  followText = "Follow";
                                                  isFollowed = false;
                                                });
                                              }
                                            }
                                          },
                                          child: Text(
                                            followText,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        )
                                      : TextButton(
                                          onPressed: () async {
                                            String url =
                                                kAppUrl + "/follow/upload/";
                                            FormData formData =
                                                FormData.fromMap({
                                              'userId': myid,
                                              'followedUID':
                                                  widget.userid.toString()
                                            });
                                            var resp = await Dio()
                                                .post(url, data: formData);
                                            print("UNFOLLOWED RESPONSE");
                                            print(resp.statusCode);
                                            if (resp.statusCode == 200) {
                                              VxToast.show(context,
                                                  msg: "UnFollowed");
                                              setState(() {
                                                followText = "Following";
                                                isFollowed = true;
                                              });
                                            }
                                          },
                                          child: Text(
                                            followText,
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _allLongVideos!.length,
                                itemBuilder: (context, index) {
                                  return GridTile(
                                    child: GestureDetector(
                                      onTap: () {
                                        playVideo(
                                            _allLongVideos![index].videoUrl,
                                            _allLongVideos![index].id,
                                            _allLongVideos![index].userId);
                                      },
                                      child: LongVideoCard(
                                          id: _allLongVideos![index].id,
                                          username:
                                              _allLongVideos![index].username,
                                          profilePic:
                                              _allLongVideos![index].userPic,
                                          thumbnailUrl: kImageUrl +
                                              _allLongVideos![index]
                                                  .thumbnailUrl,
                                          createdOn:
                                              _allLongVideos![index].createdOn,
                                          title: _allLongVideos![index].title,
                                          hastag:
                                              _allLongVideos![index].hasTags,
                                          location:
                                              _allLongVideos![index].location,
                                          noOfView:
                                              _allLongVideos![index].noOfView,
                                          noOfComment: _allLongVideos![index]
                                              .noOfComment,
                                          noOfDislikes: _allLongVideos![index]
                                              .noOfDislikes,
                                          noOfLikes:
                                              _allLongVideos![index].noOfLikes,
                                          videoUrl:
                                              _allLongVideos![index].videoUrl),
                                    ),
                                  );
                                }),
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
            ),
    );
  }
}
