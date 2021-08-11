import 'package:badges/badges.dart';
import 'package:flickzone/constants.dart';
import 'package:flickzone/models/notificationsModel.dart';
import 'package:flickzone/screens/profileOther.dart';
import 'package:flickzone/widgets/loadNotifications.dart';
import 'package:flickzone/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
        backgroundColor: Vx.gray500,
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
      floatingActionButton: VxCircle(
        child: (Icon(
          Icons.add,
          color: Vx.white,
        )),
        radius: 50,
        backgroundColor: Vx.lightBlue400,
      ),
      bottomNavigationBar: bottomBar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
