import 'package:flickzone/screens/homescreen.dart';
import 'package:flickzone/screens/notifications.dart';
import 'package:flickzone/screens/profile.dart';
import 'package:flickzone/screens/search.dart';
import 'package:flutter/material.dart';

class bottomBar extends StatelessWidget {
  const bottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
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
    );
  }
}
