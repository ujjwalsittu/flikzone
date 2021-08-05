import 'package:badges/badges.dart';
import 'package:flickzone/constants.dart';
import 'package:flickzone/screens/profileOther.dart';
import 'package:flickzone/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:velocity_x/velocity_x.dart';

String kNotificationRoute = "/notifications";

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Notifications".text.make(),
        centerTitle: true,
        backgroundColor: Vx.gray500,
      ),
      body: new ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(bottom: 8, top: 8, left: 5, right: 5),
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
                    badgeContent: Icon(kNotifications[index].icon, size: 10),
                    position: BadgePosition.bottomEnd(),
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(kNotifications[index].faceUrl),
                    ),
                  ),
                  title: Text(kNotifications[index].message),
                  subtitle: Text("by " + kNotifications[index].name),
                  trailing: Text(kNotifications[index].time),
                ),
              ),
            );
          }),
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
