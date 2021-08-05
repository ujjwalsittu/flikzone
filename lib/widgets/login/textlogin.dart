/*
 * Copyright (c) 2021. All Rights Reserved, You are not allowed, distribute and modify this code under the terms of the of genric license issued by Musocial Private Limited. If any person / company wants to modify the code, he/she/they need to get developer license issued by Musocial Private Limited. If any person / company wants to distribute this code he/she/they need to get affliate / reseller license issued by Musocial Private Limited.
 * If any person / company is found to violate our copyright terms and licensing terms. we are completely liable to take legal actions under Copyright act, or any as per applicable by local law authorities.
 *
 * This code is documented and written by author : Ujjwal Kumar Sittu
 *
 */
import 'package:flutter/material.dart';

class TextLogin extends StatefulWidget {
  @override
  _TextLoginState createState() => _TextLoginState();
}

class _TextLoginState extends State<TextLogin> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 10.0),
      child: Container(
        //color: Colors.green,
        height: 200,
        width: 200,
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
            ),
            Center(
              child: Text(
                'A world of possibility in an app',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
