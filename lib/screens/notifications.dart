 import 'package:badges/badges.dart';
import 'package:flickzone/constants.dart';
import 'package:flickzone/models/notificationsModel.dart';
import 'package:flickzone/screens/homescreen.dart';
import 'package:flickzone/screens/profile.dart';
import 'package:flickzone/screens/profileOther.dart';
import 'package:flickzone/screens/search.dart';
import 'package:flickzone/widgets/loadNotifications.dart';
import 'package:flickzone/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

String kNotificationRoute = "/notifications";

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool isPressed = false;

  late String profilePic;

  late String userPic;

  late bool noPost = false;

  List<NotificationModel>? _notifications = <NotificationModel>[];

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() async {
    var box = Hive.box('OTP');
    int userid = box.get('userid');
    final postResults = await LoadNotifications().loadPosts(userid);
    print(postResults.length);

    setState(() {
      _notifications = postResults;
    });
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Notifications".text.make(),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _loadNotifications,
        // onLoading: _loadNotifications,
        child: ListView.builder(
            itemCount:
                _notifications!.length == null ? 0 : _notifications!.length,
            itemBuilder: (context, index) {
              return _notifications!.length == 0
                  ? Center(
                      child: Text("No Notifications Yet, Pull to Refresh"),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8, top: 8, left: 5, right: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, kOtherProfile);
                        },
                        child: ListTile(
                          tileColor: Vx.warmGray300,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          leading: Badge(
                            toAnimate: false,
                            shape: BadgeShape.circle,
                            badgeColor: Vx.lightBlue300,
                            badgeContent: Icon(Icons.star, size: 10),
                            position: BadgePosition.bottomEnd(),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(kDefaultPic),
                            ),
                          ),
                          title: _notifications![index].notificationType == 4
                              ? Text("System Notification")
                              : Text("User Notification"),
                          subtitle: Text(_notifications![index].content),
                          trailing: Text(
                              DateTime.parse(_notifications![index]
                                      .createdOn
                                      .toString())
                                  .timeAgo(
                                      enableFromNow: true, useShortForm: false)
                                  .firstLetterUpperCase(),
                              style: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    );
            }),
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
                onPressed: () {
                  Navigator.pushNamed(context, kSearchPage);
                },
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
                  // Navigator.pushNamed(context, kNotificationRoute);
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
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
