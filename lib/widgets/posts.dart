import 'dart:convert';
import 'dart:math';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:dio/dio.dart';
import 'package:flickzone/constants.dart';
import 'package:flickzone/models/commentModel.dart';
import 'package:flickzone/models/postModel.dart';
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

  void profileDetails() async {
    var box = Hive.box('OTP');
    int userid = box.get("userid");
    var url = Uri.http("15.207.105.12:4040", 'user/$userid');
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
                      new Container(
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
                      new SizedBox(
                        width: 10.0,
                      ),
                      new Text(
                        _posts![index].username.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  new IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: null,
                  )
                ],
              ),
            ),
            _posts![index].hasImage == 1
                ? Flexible(
                    fit: FlexFit.loose,
                    child: new Image.network(
                      kAppUrl + "/" + _posts![index].postImage.toString(),
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
                  Text(_posts![index].noOfLikes.toString() +
                      " people liked this")
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
                    icon: _posts![index].isLiked == 1
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
                      setState(() async {
                        if (_posts![index].isLiked == 1) {
                          final url =
                              "http://15.207.105.12:4040/likesanddislikes/delete/" +
                                  contentId +
                                  "/" +
                                  myid.toString();
                          print(url);
                          Dio().delete(url);
                        } else {
                          try {
                            print(myidd);
                            FormData formData = FormData.fromMap({
                              "userId": _myid,
                              "isPostLike": 1,
                              "contentId": contentId
                            });
                            final res = await Dio().post(
                                "http://15.207.105.12:4040/likesanddislikes/upload",
                                data: formData);
                            print(res.data);
                            print("Likes Working");
                          } on DioError catch (e) {
                            print(e.response!.statusCode);
                          }
                        }
                      });
                    },
                  ),
                  // ignore: unnecessary_new
                  new SizedBox(
                    child: "|".text.make(),
                    width: 16.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      String _comment;
                      List<CommentModel> _comments = <CommentModel>[];
                      final resp = await CommentWebServices()
                          .loadComment(_posts![index].id!);
                      setState(() {
                        _comments = resp;
                      });
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            // return FutureBuilder<CommentModel>(
                            //     builder: (context, snapshot) {
                            return ListView.builder(
                                itemCount: _comments.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      leading: Image.network(kDefaultPic),
                                      title: Text(_comments[index].content),
                                      subtitle: Text(
                                        DateTime.parse(_comments[index]
                                                .createdOn
                                                .toString())
                                            .timeAgo(
                                                enableFromNow: true,
                                                useShortForm: false)
                                            .firstLetterUpperCase(),
                                        style: TextStyle(color: Colors.grey),
                                      ));
                                });
                          });
                      // });
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
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(
                            _posts![index].profilepic.toString()),
                      ),
                    ),
                  ),
                  new SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: new TextField(
                      onChanged: (value) {
                        setState(() {
                          _comment = value;
                        });
                      },
                      controller: textEditingController,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        enabled: true,
                        hintText: "Add a comment...",
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var box = Hive.box('OTP');
                      print(_myid);
                      if (_comment == " " || _comment.isEmptyOrNull) {
                        VxToast.show(context,
                            msg: "Empty Comment Will Not Be Sent");
                      } else {
                        FormData formData = FormData.fromMap({
                          "content": _comment,
                          "postId": _posts![index].id,
                          "userId": _myid
                        });
                        print(_myid);
                        final resp = await Dio().post(
                            "http://15.207.105.12:4040/comment/upload",
                            data: formData);

                        if (resp.statusCode == 200) {
                          VxToast.show(context, msg: "Comment Posted");
                          print(resp.data);
                          textEditingController.clear();
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
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
