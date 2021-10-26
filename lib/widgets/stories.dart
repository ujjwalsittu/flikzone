import 'package:flickzone/constants.dart';
import 'package:flickzone/models/StoryModel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'StoryWebServices.dart';

class Stories extends StatefulWidget {
  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  final _momentCount = 5;
  final _momentDuration = const Duration(seconds: 5);
  @override
  void initState() {
    super.initState();
    loadStories();
  }

  int storyLength = 0;

  List<StoryModel> storyList = <StoryModel>[];
  void loadStories() async {
    var box = Hive.box('OTP');
    int userid = box.get('userid');
    final respi = await StoryWebServices().loadStory();
    if (respi.length != 0) {
      setState(() {
        storyList = respi;
      });
    }
  }

  final topText = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        "Stories",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Row(
        children: <Widget>[
          // new Icon(Icons.play_arrow),
          // new Text("Watch All", style: TextStyle(fontWeight: FontWeight.bold))
        ],
      )
    ],
  );

  Widget stories() {
    return Expanded(
      child: new Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: new ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: storyLength,
          itemBuilder: (context, index) => new Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              new Container(
                width: 50.0,
                height: 50.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://cdn.club42.online/upload/photos/d-page.jpg"),
                  ), // Stories Faces
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
              ),
              index == 0
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/storyupload");
                      },
                      child: Positioned(
                          right: 10.0,
                          child: new CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 10.0,
                            child: new Icon(
                              Icons.add,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          )),
                    )
                  : new Container()
            ],
          ),
        ),
      ),
    );
  }
  // final stories =

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(10.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          topText,
          stories(),
        ],
      ),
    );
  }
}
