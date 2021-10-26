import 'dart:io';

import 'package:flickzone/constants.dart';
import 'package:flickzone/models/BannerModel.dart';
import 'package:flickzone/models/SearchModel.dart';
import 'package:flickzone/screens/SingleLongVideo.dart';
import 'package:flickzone/screens/SinglePostScreen.dart';
import 'package:flickzone/screens/homescreen.dart';
import 'package:flickzone/screens/notifications.dart';
import 'package:flickzone/screens/profile.dart';
import 'package:flickzone/screens/profileOther.dart';
import 'package:flickzone/services/BannerWebServices.dart';
import 'package:flickzone/services/SearchWebServices.dart';
import 'package:flickzone/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:velocity_x/velocity_x.dart';

String kSearchPage = "/search";

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    loadBanner();
  }

  bool searched = false;
  List<User> _user = <User>[];
  List<Post> _post = <Post>[];
  List<Video> _video = <Video>[];
  bool userData = false;
  bool userPData = false;
  int bannerindex = 0;
  bool userVData = false;
  int userid = 0;
  TextEditingController _textEditingController = TextEditingController();
  List _bannerList = [];
  PageController? _pageController;
  var box = Hive.box('OTP');
  void loadBanner() async {
    userid = box.get('userid');
    final res = await BannerWebService().loadBanner();
    if (res.isNotEmpty) {
      _bannerList = res;
      print(_bannerList);
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

  int searchSelectTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.pink100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Opacity(
                  opacity: 0.7,
                  child: OutlineSearchBar(
                    onTypingFinished: (value) {
                      print(value);
                    },
                    textEditingController: _textEditingController,
                    onClearButtonPressed: (value) {
                      print("cleared");
                      searched = false;
                      _textEditingController.clear();
                    },
                    onSearchButtonPressed: (value) async {
                      final res = await SearchWebService().loadSearch(value);
                      final pRes =
                          await SearchWebService().loadPostSearch(value);
                      final vRes =
                          await SearchWebService().loadVideoSearch(value);
                      setState(() {
                        if (res.isNotEmpty) {
                          userData = true;
                          searched = true;
                        }
                        if (pRes.isNotEmpty) {
                          userPData = true;
                          searched = true;
                        }
                        if (vRes.isNotEmpty) {
                          userPData = true;
                          searched = true;
                        }

                        _user = res;
                        _post = pRes;
                        _video = vRes;
                        // print(_user[].fullName);
                      });
                    },
                    borderRadius: BorderRadius.circular(25),
                    elevation: 1,
                    icon: Icon(
                      Icons.search,
                      color: Vx.black,
                    ),
                    hintText: "Search",
                    backgroundColor: Vx.gray100,
                  ),
                ),
              ),
              searched
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                searchSelectTab = 0;
                                // print(selectedTab);
                              });
                            },
                            child: Icon(Icons.supervised_user_circle)),
                        "|".text.make(),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                searchSelectTab = 1;
                                print(searchSelectTab);
                              });
                            },
                            child: Icon(Icons.post_add)),
                        "|".text.make(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              searchSelectTab = 2;
                              print(searchSelectTab);
                            });
                          },
                          child: Icon(Icons.play_circle_outline_sharp),
                        ),
                      ],
                    )
                  : SizedBox(),
              searched
                  ? searchSelectTab == 0
                      ? userData
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: _user.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      goToProfile(_user[index].id);
                                    },
                                    child: VxCapsule(
                                      height: MediaQuery.of(context)
                                              .devicePixelRatio *
                                          25,
                                      backgroundColor: Colors.white,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              _user[index].profilepic),
                                        ),
                                        title: Text(_user[index].fullName),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                        subtitle: Row(
                                          children: [
                                            Text("Likes  "),
                                            Text(_user[index]
                                                .totalLikes
                                                .toString()),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Followers  "),
                                            Text(_user[index]
                                                .totalFollowers
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : Center(
                              child: Text("No Data Found"),
                            )
                      : searchSelectTab == 1
                          ? userPData
                              ? GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4),
                                  itemBuilder: (BuildContext ctx, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (_) => SinglePostScreen(
                                                  id: _post[index].id,
                                                  userid: userid)),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: VxContinuousRectangle(
                                          radius: 40,
                                          height: 150,
                                          width: 80,
                                          backgroundImage: DecorationImage(
                                              image: NetworkImage((kImageUrl +
                                                  _post[index].postImage)),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: _post.length,
                                )
                              : Center(
                                  child: Text("No Data Found"),
                                )
                          : searchSelectTab == 2
                              ? GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4),
                                  itemBuilder: (BuildContext ctx, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                            builder: (_) => SingleLongVideo(
                                              id: _video[index].id,
                                              userid: userid,
                                              url: _video[index].videoUrl,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: VxContinuousRectangle(
                                          radius: 40,
                                          height: 150,
                                          width: 80,
                                          backgroundImage: DecorationImage(
                                              image: NetworkImage((kImageUrl +
                                                  _video[index].thumbnailUrl)),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: _video.length,
                                )
                              : Center(
                                  child: Text("No Data Found"),
                                )
                  : Column(
                      children: [
                        "#Trendings".text.align(TextAlign.left).make(),
                        GFCarousel(
                          items: _bannerList.map(
                            (url) {
                              return Container(
                                margin: EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: Image.network(
                                      kVideoUrl +
                                          "/" +
                                          _bannerList[bannerindex]["imgUrl"],
                                      fit: BoxFit.cover,
                                      width: 1000.0),
                                ),
                              );
                            },
                          ).toList(),
                          onPageChanged: (index) {
                            setState(() {
                              index;
                              bannerindex = index;
                            });
                          },
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          Alert(
            context: context,
            type: AlertType.info,
            title: "Create Flicks",
            desc: "Select Flick Type You Want to Create.",
            buttons: [
              DialogButton(
                child: Text(
                  "LongFlik",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () => Navigator.pushNamed(context, "/upload"),
                color: Color.fromRGBO(0, 179, 134, 1.0),
              ),
              DialogButton(
                child: Text(
                  "ShortFlik",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () {
                  // if (Platform.isAndroid) {
                  //   _startVideoEditorActivity();
                  // } else if (Platform.isIOS) {
                  //   _startIOSVideoEditorActivity();
                  // } else {
                  //   _showAlert(context, "Platform is not supported!");
                  // }
                  VxToast.show(context, msg: "Under Development");
                },
                gradient: LinearGradient(colors: [
                  Color.fromARGB(116, 116, 191, 1),
                  Color.fromRGBO(52, 138, 199, 1.0)
                ]),
              ),
              DialogButton(
                child: Text(
                  "PostFlik",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/postcreate");
                },
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(116, 116, 191, 1.0),
                  Color.fromRGBO(52, 138, 199, 1.0)
                ]),
              ),
            ],
          ).show();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 50.0,
        alignment: Alignment.center,
        child: new BottomAppBar(
          child: new Row(
            // alignment: MainAxisAlignment.spaceAround,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // new IconButton(
              //   icon: Icon(
              //     Icons.home,
              //   ),
              //   onPressed: () {
              //     Navigator.pushNamed(context, kHomeRoute);
              //   },
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, kHomeRoute);
                },
                child: new Image.asset(
                  'assets/icons/home.png',
                  scale: 2.5,
                ),
              ),
              new IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {},
              ),
              // new IconButton(
              //   icon: Icon(
              //     Icons.add_box,
              //   ),
              //   onPressed: null,
              // ),
              new SizedBox(),
              new IconButton(
                icon: Icon(
                  Icons.notifications,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, kNotificationRoute);
                },
              ),
              new IconButton(
                icon: Icon(
                  Icons.account_box,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, kProfileScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
