import 'package:flickzone/constants.dart';
import 'package:flickzone/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

String kProfileScreen = "/profile";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedTab = 0;
  var box = Hive.box('OTP');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.gray300,
        title: "amansingh".text.gray700.make(),
        iconTheme: IconThemeData(color: Vx.black),
        actionsIconTheme: IconThemeData(color: Vx.black),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  box.deleteFromDisk();
                  Navigator.pushNamed(context, "/");
                },
                child: Center(child: FaIcon(Icons.menu_open_sharp))),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: VxCircle(
                        radius: 100,
                        border: Border.all(width: 4, color: Vx.lightBlue300),
                        backgroundImage: DecorationImage(
                            image: NetworkImage(
                                "https://images.unsplash.com/photo-1613995948078-90d582bed4c7?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        "12".text.bold.gray400.xl2.make(),
                        "Posts".text.gray400.make(),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      children: [
                        "1000".text.bold.gray400.xl2.make(),
                        "Followers".text.gray400.make(),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      children: [
                        "200".text.bold.gray400.xl2.make(),
                        "Following".text.gray400.make(),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "@aman_singh".text.xl2.gray500.bold.make(),
                    "Artist".text.xl.gray400.make(),
                    "Bio Goes Here".text.xl.gray500.make()
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = 0;
                          print(selectedTab);
                        });
                      },
                      child: Icon(Icons.apps)),
                  "|".text.make(),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = 1;
                          print(selectedTab);
                        });
                      },
                      child: Icon(Icons.center_focus_weak)),
                  "|".text.make(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = 2;
                        print(selectedTab);
                      });
                    },
                    child: Icon(Icons.play_circle_outline_sharp),
                  ),
                ],
              ),
              selectedTab == 0
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image: NetworkImage(imageurl + "1/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "28/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "23/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "30/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "29/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "10/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "11/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "12/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "13/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "14/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "15/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "16/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "17/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "18/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "19/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "20/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "25/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "26/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "24/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxContinuousRectangle(
                                radius: 40,
                                height: 125,
                                width: 80,
                                backgroundImage: DecorationImage(
                                    image:
                                        NetworkImage(imageurl + "31/200/300"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : selectedTab == 1
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "98/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "88/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "85/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "30/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "29/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "10/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "11/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "12/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "13/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "14/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "15/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "16/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "17/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "18/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "19/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "20/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "25/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "26/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "24/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "31/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "50/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "56/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "57/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "30/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "29/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "10/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "11/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "12/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "13/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "14/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "15/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "16/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "17/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "18/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "19/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "20/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "25/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "26/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "24/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: VxContinuousRectangle(
                                    radius: 40,
                                    height: 125,
                                    width: 80,
                                    backgroundImage: DecorationImage(
                                        image: NetworkImage(
                                            imageurl + "31/200/300"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
            ],
          ),
        ),
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
