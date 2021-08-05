import 'package:flickzone/models/VideoModel.dart';
import 'package:flickzone/screens/profile.dart';
import 'package:flickzone/screens/search.dart';
import 'package:flickzone/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

String kLongVideo = "/longvideo";

class LongVideo extends StatefulWidget {
  @override
  _LongVideoState createState() => _LongVideoState();
}

class _LongVideoState extends State<LongVideo> with TickerProviderStateMixin {
  late AnimationController alignmentAnimationController;
  late Animation alignmentAnimation;

  late AnimationController videoViewController;
  late Animation videoViewAnimation;

  var currentAlignment = Alignment.topCenter;

  var minVideoHeight = 100.0;
  var minVideoWidth = 150.0;

  var maxVideoHeight = 200.0;

  // This is an arbitrary value and will be changed when layout is built.
  var maxVideoWidth = 250.0;

  var currentVideoHeight = 200.0;
  var currentVideoWidth = 200.0;

  bool isInSmallMode = false;

  var videoIndexSelected = -1;

  @override
  void initState() {
    super.initState();

    alignmentAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
            setState(() {
              currentAlignment = alignmentAnimation.value;
            });
          });
    alignmentAnimation =
        AlignmentTween(begin: Alignment.topCenter, end: Alignment.bottomRight)
            .animate(CurvedAnimation(
                parent: alignmentAnimationController,
                curve: Curves.fastOutSlowIn));

    videoViewController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
            setState(() {
              currentVideoWidth = (maxVideoWidth * videoViewAnimation.value) +
                  (minVideoWidth * (1.0 - videoViewAnimation.value));
              currentVideoHeight = (maxVideoHeight * videoViewAnimation.value) +
                  (minVideoHeight * (1.0 - videoViewAnimation.value));
            });
          });
    videoViewAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(videoViewController);
  }

  var videos = [
    VideoItemModel(
        "Gordon Ramsay Cooked For Vladimir Putin",
        "The Late Show with Stephen Colbert\n1.1M views.2 weeks ago",
        "assets/youtube_one.jpg"),
    VideoItemModel("Hailee Steinfeld, Alesso - Let Me Go",
        "Hailee Steinfeld\n57M views.8 months ago", "assets/youtube_two.jpg"),
    VideoItemModel("Charlie Puth - Look At Me Now",
        "Lyricwood\n4.7M views.4 months ago", "assets/youtube_three.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.play,
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "FlickZone",
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: -1.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GestureDetector(
                onTap: () {
                  VxToast.show(context, msg: "Under Development");
                },
                child: Icon(
                  Icons.videocam,
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, kSearchPage);
                },
                child: Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, kProfileScreen);
                },
                child: Icon(
                  Icons.account_circle,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
        body: Stack(children: [
          new Center(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, position) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      // videoIndexSelected = position;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 330,
                      width: 100,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                child: Image.asset(
                                  videos[position].imagePath,
                                  fit: BoxFit.cover,
                                ),
                              )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 40.0,
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4.0),
                                        child: Text(
                                          videos[position].title,
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                      ),
                                      Text(
                                        videos[position].publisher,
                                        style: TextStyle(color: Colors.black54),
                                      )
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                  flex: 9,
                                ),
                                Expanded(
                                  child: Icon(Icons.more_vert),
                                  flex: 1,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          videoIndexSelected > -1
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    maxVideoWidth = constraints.biggest.width;

                    if (!isInSmallMode) {
                      currentVideoWidth = maxVideoWidth;
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            child: Padding(
                              padding:
                                  EdgeInsets.all(isInSmallMode ? 8.0 : 0.0),
                              child: GestureDetector(
                                child: Container(
                                  width: currentVideoWidth,
                                  height: currentVideoHeight,
                                  child: Image.asset(
                                    videos[videoIndexSelected].imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.blue,
                                ),
                                onVerticalDragEnd: (details) {
                                  if (details.velocity.pixelsPerSecond.dy > 0) {
                                    setState(() {
                                      isInSmallMode = true;
                                      alignmentAnimationController.forward();
                                      videoViewController.forward();
                                    });
                                  } else if (details
                                          .velocity.pixelsPerSecond.dy <
                                      0) {
                                    setState(() {
                                      alignmentAnimationController.reverse();
                                      videoViewController
                                          .reverse()
                                          .then((value) {
                                        setState(() {
                                          isInSmallMode = false;
                                        });
                                      });
                                    });
                                  }
                                },
                              ),
                            ),
                            alignment: currentAlignment,
                          ),
                          flex: 3,
                        ),
                        currentAlignment == Alignment.topCenter
                            ? Expanded(
                                flex: 6,
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Row(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Video Recommendation"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Video Recommendation"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Video Recommendation"),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  color: Colors.white,
                                ),
                              )
                            : Container(),
                        Row(),
                      ],
                    );
                  },
                )
              : Container()
        ]),
        floatingActionButton: VxCircle(
          child: (Icon(
            Icons.add,
            color: Vx.white,
          )),
          radius: 50,
          backgroundColor: Vx.lightBlue400,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: bottomBar());
  }
}

// class LongVideo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               color: Vx.pink100,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 5, 16, 0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(16, 8, 6, 6),
//                           child: "Flickzone".text.bold.xl.gray600.make(),
//                         ),
//                         GestureDetector(
//                             onTap: () {
//                               Navigator.pushNamed(context, kMessage);
//                             },
//                             child: FaIcon(FontAwesomeIcons.paperPlane)),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       VxContinuousRectangle(
//                         height: 50,
//                         width: MediaQuery.of(context).size.shortestSide,
//                         backgroundColor: Vx.pink100,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               const Icon(
//                                 FontAwesomeIcons.home,
//                                 size: 25,
//                               ),
//                               "|".text.make(),
//                               const Icon(
//                                 Icons.video_collection_rounded,
//                                 size: 25,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ).shadowXs,
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: OutlineSearchBar(
//                       icon: Icon(Icons.search),
//                       hintText: "Search For Your Fav Creator",
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       color: Vx.white,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             VxContinuousRectangle(
//                               backgroundImage: DecorationImage(
//                                   image: NetworkImage(kPosts[1].PostImag),
//                                   fit: BoxFit.cover),
//                             ),
//                             Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.fromLTRB(
//                                     16,
//                                     8,
//                                     0,
//                                     0,
//                                   ),
//                                   child: CircleAvatar(
//                                     backgroundImage:
//                                         NetworkImage(kPosts[1].faceUrl),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: "Video Title 1 | Indian Comedy | Hello"
//                                       .text
//                                       .bold
//                                       .make(),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
//                               child:
//                                   "T-Series   - 3.8M   . Jul,2020".text.make(),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
