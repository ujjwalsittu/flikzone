import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flickzone/constants.dart';
import 'package:flickzone/models/commentModel.dart';
import 'package:flickzone/widgets/CommentWebServices.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class LVComment extends StatefulWidget {
  String postId = "0";
  String videoId = "0";
  String replyId = "0";
  LVComment(this.postId, this.videoId, this.replyId);

  @override
  _LVCommentState createState() => _LVCommentState();
}

class _LVCommentState extends State<LVComment> {
  TextEditingController textEditingController = TextEditingController();
  late String _comment;
  List<CommentModel>? _allComments = <CommentModel>[];
  bool isLoading = true;

  void loadComments() async {
    final resp = await CommentWebServices()
        .loadCommentByCType(widget.postId, widget.videoId, widget.replyId);
    if (resp.length != 0) {
      setState(() {
        _allComments = resp;
        isLoading = false;
        print("FETCHED LENGTH");
        print(_allComments?.length);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        title: widget.replyId == "0" ? Text("Comment") : Text("Reply"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: _allComments!.isEmpty
          ? Center(
              child:
                  widget.replyId == "0" ? Text("No Comment") : Text("No Reply"),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: _allComments!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(_allComments![index].userPic),
                  ),
                  title: Text(_allComments![index].content),
                  subtitle: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 2),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/blank_heart.png",
                              scale: 2,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(_allComments![index].likes.toString())
                          ],
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/blank-broken-heart.png",
                              scale: 2,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(_allComments![index].dislikes.toString())
                          ],
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (_) => LVComment("0", "0",
                                      _allComments![index].id.toString()),
                                ),
                              );
                            },
                            child: Text(
                                "Replies(${_allComments![index].maxReply})")),
                        SizedBox(
                          width: 5,
                        ),
                        Text(DateTime.parse(
                                _allComments![index].createdOn.toString())
                            .timeAgo(enableFromNow: true, useShortForm: false)
                            .firstLetterUpperCase())
                      ],
                    ),
                  ),
                );
              }),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
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
                int userid = box.get("userid");
                if (_comment == " " || _comment.isEmptyOrNull) {
                  VxToast.show(context, msg: "Empty Comment Will Not Be Sent");
                } else {
                  FormData formData = FormData.fromMap({
                    "content": _comment,
                    "postId": widget.postId,
                    "videoId": widget.videoId,
                    "replyId": widget.replyId,
                    "userId": userid
                  });
                  print("$userid  printed");
                  final resp = await Dio()
                      .post(kAppUrl + "/comment/upload", data: formData);

                  if (resp.statusCode == 200) {
                    VxToast.show(context, msg: "Comment Posted");
                    print(resp.data);
                    textEditingController.clear();
                    loadComments();
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
    );
  }
}
