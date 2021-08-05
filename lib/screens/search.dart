import 'package:flickzone/constants.dart';
import 'package:flickzone/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:velocity_x/velocity_x.dart';

String kSearchPage = "/search";

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int searchSelect = 0;
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: VxContinuousRectangle(
                  height: 120,
                  radius: 50,
                  backgroundImage: DecorationImage(
                      image: const NetworkImage(
                          "https://images.unsplash.com/photo-1527529482837-4698179dc6ce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80"),
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            searchSelect = 0;
                          });
                        },
                        child: Text(
                          "Trending",
                          style: TextStyle(
                              color: searchSelect == 0
                                  ? Vx.lightBlue600
                                  : Vx.gray500),
                        )),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            searchSelect = 1;
                          });
                        },
                        child: Text(
                          "For You",
                          style: TextStyle(
                              color: searchSelect == 1
                                  ? Vx.lightBlue600
                                  : Vx.gray500),
                        )),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            searchSelect = 2;
                          });
                        },
                        child: Text(
                          "Celebrities",
                          style: TextStyle(
                              color: searchSelect == 2
                                  ? Vx.lightBlue600
                                  : Vx.gray500),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "#quarantine".text.gray500.make(),
                    Icon(Icons.arrow_forward_ios_sharp, color: Vx.gray400),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kQuarantineImg[0]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kQuarantineImg[1]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kQuarantineImg[2]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kQuarantineImg[3]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kQuarantineImg[4]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kQuarantineImg[5]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kQuarantineImg[6]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kQuarantineImg[7]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "#enjoylife".text.gray500.make(),
                    Icon(Icons.arrow_forward_ios_sharp, color: Vx.gray400),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[0]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[1]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[2]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[3]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[4]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[5]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[6]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[7]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "#enjoylife".text.gray500.make(),
                    Icon(Icons.arrow_forward_ios_sharp, color: Vx.gray400),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[0]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[1]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[2]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[3]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[4]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[5]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[6]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GridTile(
                        child: VxContinuousRectangle(
                          width: 95,
                          height: 115,
                          backgroundImage: DecorationImage(
                              image: NetworkImage(kPartyImg[7]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                ),
              ),
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
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: bottomBar(),
    );
  }
}
