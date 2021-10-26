import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flickzone/constants.dart';
import 'package:flickzone/screens/homescreen.dart';
import 'package:flickzone/widgets/login/VerticalText.dart';
import 'package:flickzone/widgets/login/textlogin.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';
import 'package:velocity_x/velocity_x.dart';

String kLoginScreen = "/login";

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TwilioFlutter? twilioFlutter;
  bool showLoader = false;
  Box<dynamic>? box;
  var dio = Dio();

  void initState() {
    box = Hive.box('OTP');
    twilioFlutter = TwilioFlutter(
      accountSid: twilioSID,
      authToken: twilioToken,
      twilioNumber: twilioNumber,
    );
  }

  void sendOTP(String number, message) async {
    twilioFlutter?.sendSMS(toNumber: "+91" + number, messageBody: message);
  }

  Future<void> login(dynamic number) async {
    String num = number.toString();

    var formData = FormData.fromMap({'phoneNo': num, 'otpVerified': 1});
    try {
      var response = await dio.post('$kAppUrl/user/signup', data: formData);

      final result = response.data;
      // String results = jsonDecode(result);
      print(result);
      if (response.statusCode == 200 && result["success"] == true) {
        var future = box?.putAll({
          'token': result["token"],
          'userid': result["data"][0]["id"],
          'fullname': result["data"][0]["fullName"],
          'username': result["data"][0]["username"],
          'profilepic': result["data"][0]["profilepic"],
          'islogged': true,
        });

        print(box?.get("token"));
        print(box?.get("userid"));
        print(box?.get("fullname"));
        print(box?.get("phoneNo"));
        print(box?.get("username"));
        print(box?.get("token"));
        Navigator.pushNamed(context, kHomeRoute);
      }
    } on DioError catch (e) {
      setState(() {
        showLoader = false;
      });
      VxToast.show(context,
          msg: "Error While Logging In With MSG : ${e.response?.data["msg"]}");
      print(e.response?.statusCode);
    }
  }

  late dynamic phoneNumber;
  bool resend = false;
  late String enteredOTP;
  void sendWhatsApp() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.pinkAccent]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'assets/images/logo-white.png',
                    height: 50,
                  ),
                ),
                Row(children: <Widget>[
                  VerticalText(),
                  TextLogin(),
                ]),
                //INPUT MOBILE NUMBER

                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.lightBlueAccent,
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        setState(() {
                          phoneNumber = value;
                          print(phoneNumber);
                        });
                      },
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    // var box = await Hive.openBox('OTP');

                    int? otp = box?.get('otp');
                    print(otp);
                    String msg = "$otpMessage  $otp -  Flikzone";
                    sendOTP(phoneNumber, msg);
                    VxToast.show(context,
                        msg: "OTP Sent, wait for 1 minute before retry $otp",
                        position: VxToastPosition.center,
                        showTime: 2500);
                    setState(() {
                      resend = true;
                    });
                  },
                  child: resend
                      ? "Resend OTP".text.make()
                      : "Send OTP".text.make(),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'OTP',
                        labelStyle: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          enteredOTP = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10, right: 100, left: 100),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Vx.blue300,
                          blurRadius:
                              10.0, // has the effect of softening the shadow
                          spreadRadius:
                              1.0, // has the effect of extending the shadow
                          offset: Offset(
                            5.0, // horizontal, move right 10
                            5.0, // vertical, move down 10
                          ),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        // var box = await Hive.openBox('OTP');
                        if (showLoader == true) CircularProgressIndicator();

                        int temp = box?.get('otp');
                        if (temp.toString() == enteredOTP &&
                            phoneNumber != null) {
                          phoneNumber = phoneNumber.toString();
                          print(phoneNumber);

                          await login(phoneNumber);
                          // VxToast.show(context, msg: phoneNumber);
                        } else {
                          VxToast.show(context,
                              msg: "You have entered an incorrect OTP .",
                              position: VxToastPosition.center,
                              showTime: 2250);
                          setState(() {
                            showLoader = false;
                          });
                        }
                        // box.close();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.lightBlueAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
