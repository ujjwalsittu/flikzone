import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flickzone/constants.dart';
import 'package:flickzone/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  String fullName = "Full Name";
  String profilePic = kDefaultPic;
  String username = "Username";
  int noOfPost = 0;
  int totalFollowers = 0;
  bool dataChanged = false;
  bool picChanged = false;
  int totalpost = 0;
  int verified = 0;
  int totalVideos = 0;
  String phoneNo = "0";
  late dynamic profileResp;
  var box = Hive.box('OTP');
  var dio = Dio();
  int uid = 0;
  void profileDetails() async {
    int userid = box.get("userid");
    var url = Uri.http(kAppUrlHalf, 'user/$userid');
    var response = await http.get(url);
    profileResp = jsonDecode(response.body);
    if (response.statusCode == 200) {
      uid = userid;
      setState(() {
        print(profileResp);
        fullName = profileResp['data'][0]['fullName'];
        profilePic = profileResp['data'][0]['profilepic'];
        username = profileResp['data'][0]["username"];
        noOfPost = profileResp['data'][0]['noOfLongVideo'] +
            profileResp['data'][0]['noOfLongShort'] +
            profileResp['data'][0]['noOfPost'];
        totalVideos = profileResp['data'][0]['noOfLongVideo'] +
            profileResp['data'][0]['noOfLongShort'];
        verified = profileResp['data'][0]['verificationStatus'];
        // print(noOfPost);
        totalFollowers = profileResp['data'][0]['totalFollowers'];
        phoneNo = profileResp['data'][0]['phoneNo'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    profileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("Update Profile"),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).popAndPushNamed(kProfileScreen);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage(picChanged ? profilePic : profilePic),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.image,
                    );
                  },
                  child: Text("Click to Change Image")),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: TextEditingController(text: fullName),
                  autofocus: false,
                  onChanged: (value) {
                    setState(() {
                      fullName = value;
                      dataChanged = true;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Your Full Name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 35.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: TextEditingController(text: username),
                  autofocus: false,
                  onChanged: (value) {
                    setState(() {
                      username = value;
                      dataChanged = true;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Your Username",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 35.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: new TextEditingController.fromValue(
                      new TextEditingValue(
                          text: phoneNo,
                          selection: new TextSelection.collapsed(
                              offset: fullName.length))),
                  autofocus: false,
                  autocorrect: false,
                  onChanged: (value) {
                    setState(() {
                      phoneNo = value;
                      dataChanged = true;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Your Contact Number",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 35.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 28,
              ),
              dataChanged
                  ? ElevatedButton(
                      onPressed: () async {
                        FormData formdata = FormData.fromMap({
                          'fullName': fullName,
                          'username': username,
                          'phoneNo': phoneNo
                        });
                        var resp = await dio.patch(
                            kAppUrl + "/user/update/" + uid.toString(),
                            data: formdata);
                      },
                      child: Text("Save Details"))
                  : Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
