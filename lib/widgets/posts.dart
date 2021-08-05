import 'package:flickzone/constants.dart';
import 'package:flickzone/models/postModel.dart';
import 'package:flickzone/widgets/postWebServ.dart';
import 'package:flickzone/widgets/stories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class Post extends StatefulWidget {
  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool isPressed = false;
  late String profilePic;
  late String userPic;
  List<PostModel>? _posts = <PostModel>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadposts();
  }

  void _loadposts() async {
    var box = Hive.box('OTP');
    int userid = box.get('userid');
    final postResults = await PostWebServices().loadPosts(userid);
    setState(() {
      _posts = postResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: _posts?.length,
      itemBuilder: (context, index) => index == null
          ? new SizedBox(
              child: new Stories(),
              height: deviceSize.height * 0.15,
            )
          : Column(
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
                          "https://" +
                              kAppUrl +
                              "/" +
                              _posts![index].postImage.toString(),
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
                      new IconButton(
                        icon: new Icon(isPressed
                            ? Icons.favorite
                            : FontAwesomeIcons.heart),
                        color: isPressed ? Colors.red : Colors.black,
                        onPressed: () {
                          setState(() {
                            isPressed = !isPressed;
                          });
                        },
                      ),
                      new SizedBox(
                        child: "|".text.make(),
                        width: 16.0,
                      ),
                      new Icon(
                        FontAwesomeIcons.comment,
                      ),
                      new SizedBox(
                        child: "|".text.make(),
                        width: 16.0,
                      ),
                      new VxContinuousRectangle(
                        height: 40,
                        width: 50,
                        backgroundColor: Vx.white,
                        backgroundImage: DecorationImage(
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
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            enabled: false,
                            hintText: "Add a comment...",
                          ),
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
    );
  }
}
