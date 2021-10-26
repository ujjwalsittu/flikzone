import 'dart:convert';
import 'dart:math';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flickzone/constants.dart';
import 'package:flickzone/models/commentModel.dart';
import 'package:flickzone/models/postModel.dart';
import 'package:flickzone/screens/LVCommentScreen.dart';
import 'package:flickzone/screens/profileOther.dart';
import 'package:flickzone/widgets/CommentWebServices.dart';
import 'package:flickzone/widgets/postWebServ.dart';
import 'package:flickzone/widgets/stories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class Post extends StatefulWidget {
  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late int myid;
  bool isPressed = false;
  late String profilePic;
  late String userPic;
  late bool noPost = false;
  List<PostModel>? _posts = <PostModel>[];
  TextEditingController textEditingController = TextEditingController();
  late String _comment;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileDetails();
    _loadposts();
  }

  void sendLike(int uid, int isPostLike, String contentid, int index) async {
    FormData formData = FormData.fromMap(
        {"userId": uid, "isPostLike": isPostLike, "contentId": contentid});

    final res =
        await Dio().post(kAppUrl + "/likesanddislikes/upload", data: formData);
    setState(() {
      if (res.statusCode == 200) {
        _posts![index].isLike = 0;
      }
    });
  }

  void profileDetails() async {
    var box = Hive.box('OTP');
    int userid = box.get("userid");
    var url = Uri.http(kAppUrlHalf, 'user/$userid');
    var response = await http.get(url);
    dynamic profileResp = jsonDecode(response.body);
    setState(() {
      myid = profileResp['data'][0]['id'];
    });
  }

  int get _myid => myid;
  void _loadposts() async {
    var box = Hive.box('OTP');
    int userid = box.get('userid');
    final postResults = await PostWebServices().loadPosts(userid);
    print(postResults.length);
    if (postResults.length == 0) {
      setState(() {
        noPost == true;
      });
    }

    setState(() {
      _posts = postResults;
    });
    print(myid);
    print("Printed");
    _refreshController.refreshCompleted();
  }

  void reportPost(int userid, int id) async {
    Response response;
    var dio = Dio();
    FormData formData = FormData.fromMap({'userId': userid, 'contentId': id});
    response = await dio.post(kAppUrl + "/video/report", data: formData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      Future.delayed(
        Duration(seconds: 1),
      );
      VxToast.show(context, msg: "Report Sent SuccessFully");
    }
  }

  goToProfile(int useriD) {
    Navigator.pop(context);
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (_) => OtherProfile(
                  userid: useriD,
                )));
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _loadposts,
      child: ListView.builder(
        itemCount: _posts?.length,
        itemBuilder: (context, index) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          goToProfile(_posts![index].userId);
                        },
                        child: new Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    _posts![index].profilepic.toString())),
                          ),
                        ),
                      ),
                      new SizedBox(
                        width: 10.0,
                      ),
                      new Text(
                        _posts![index].fullName.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  new IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.confirm,
                          text: "Do You Want To Report This Post",
                          confirmBtnText: "Yes",
                          onConfirmBtnTap: () async {
                            reportPost(myid, _posts![index].id);
                          },
                          showCancelBtn: true,
                          onCancelBtnTap: () {
                            Navigator.of(context).pop();
                          });
                    },
                  )
                ],
              ),
            ),
            _posts![index].postContent == ""
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Container(
                        child: Row(
                      children: <Widget>[
                        Flexible(
                          child: new Text(
                            _posts![index].postContent.firstLetterUpperCase(),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    )),
                  ),
            _posts![index].hasImage == 1 && _posts![index].postImage != "0"
                ? Flexible(
                    fit: FlexFit.loose,
                    child: new Image.network(
                      kVideoUrl + '/' + _posts![index].postImage.toString(),
                      fit: BoxFit.cover,
                    ),
                  )
                : SizedBox(
                    height: 1,
                  ),
            _posts![index].hasImage == 1 && _posts![index].postVideo != "0"
                ? Flexible(
                    fit: FlexFit.loose,
                    child: new Image.network(
                      kVideoUrl + '/' + _posts![index].postVideo.toString(),
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
                  _posts![index].isLike == 1
                      ? Text(
                          "You and ${_posts![index].noOfLikes.toString()} other people liked this")
                      : Text(
                          " ${_posts![index].noOfLikes.toString()} people liked this"),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
              child: Text(
                  DateTime.parse(_posts![index].createdOn.toString())
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
                    icon: _posts![index].isLike == 1
                        // ignore: prefer_const_constructors
                        ? FaIcon(
                            Icons.favorite,
                            color: Vx.red500,
                          )
                        // ignore: prefer_const_constructors
                        : FaIcon(
                            Icons.favorite_border,
                            color: Vx.gray500,
                          ),
                    onPressed: () {
                      var box = Hive.box('OTP');
                      int myidd = box.get('userid');
                      String contentId = _posts![index].id.toString();

                      if (_posts![index].isLike == 1) {
                        final url = kAppUrl +
                            "/likesanddislikes/delete/" +
                            contentId +
                            "/" +
                            myid.toString();
                        setState(() {
                          _posts![index].isLike = 0;
                        });
                        print(url);
                        Dio().delete(url);
                      } else {
                        sendLike(_myid, 1, contentId, index);
                      }
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
                          builder: (_) =>
                              LVComment("0", _posts![index].id.toString(), "0"),
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
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: <Widget>[
            //       // new Container(
            //       //   height: 40.0,
            //       //   width: 40.0,
            //       //   decoration: new BoxDecoration(
            //       //     shape: BoxShape.circle,
            //       //     image: new DecorationImage(
            //       //       fit: BoxFit.fill,
            //       //       image: new NetworkImage(
            //       //           _posts![index].profilepic.toString()),
            //       //     ),
            //       //   ),
            //       // ),
            //       // new SizedBox(
            //       //   width: 10.0,
            //       // ),
            //       // Expanded(
            //       //   child: new TextField(
            //       //     onChanged: (value) {
            //       //       setState(() {
            //       //         _comment = value;
            //       //       });
            //       //     },
            //       //     controller: textEditingController,
            //       //     decoration: new InputDecoration(
            //       //       border: InputBorder.none,
            //       //       enabled: true,
            //       //       hintText: "Add a comment...",
            //       //     ),
            //       //   ),
            //       // ),
            //       // GestureDetector(
            //       //   onTap: () async {
            //       //     var box = Hive.box('OTP');
            //       //     print(_myid);
            //       //     if (_comment == " " || _comment.isEmptyOrNull) {
            //       //       VxToast.show(context,
            //       //           msg: "Empty Comment Will Not Be Sent");
            //       //     } else {
            //       //       FormData formData = FormData.fromMap({
            //       //         "content": _comment,
            //       //         "postId": _posts![index].id,
            //       //         "userId": _myid
            //       //       });
            //       //       print(_myid);
            //       //       final resp = await Dio()
            //       //           .post(kAppUrl + "/comment/upload", data: formData);
            //       //
            //       //       if (resp.statusCode == 200) {
            //       //         VxToast.show(context, msg: "Comment Posted");
            //       //         print(resp.data);
            //       //         textEditingController.clear();
            //       //       }
            //       //     }
            //       //   },
            //       //   child: Padding(
            //       //     padding: const EdgeInsets.all(8.0),
            //       //     child: Icon(Icons.send),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            SizedBox(
              child: VxContinuousRectangle(
                height: 10,
                backgroundColor: Vx.gray200,
              ),
            )
          ],
        ),
      ),
    );
  }
}
