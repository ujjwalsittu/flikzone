/*
 * Copyright (c) 2021. All Rights Reserved, You are not allowed, distribute and modify this code under the terms of the of genric license issued by Musocial Private Limited. If any person / company wants to modify the code, he/she/they need to get developer license issued by Musocial Private Limited. If any person / company wants to distribute this code he/she/they need to get affliate / reseller license issued by Musocial Private Limited.
 * If any person / company is found to violate our copyright terms and licensing terms. we are completely liable to take legal actions under Copyright act, or any as per applicable by local law authorities.
 *
 * This code is documented and written by author :
 *
 */

import 'package:flickzone/screens/LongVideoScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    leading: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Image.asset(
        "assets/images/logo-black.png",
      ),
    ),
    leadingWidth: 250,
    elevation: 0,
    actions: [
      Image.asset(
        'assets/icons/home.png',
        scale: 2.5,
      ),
      Image.asset(
        'assets/icons/video.png',
        scale: 5.5,
      ),
      // Image.asset(
      //   'assets/icons/message.png',
      //   scale: 5.5,
      // ),
    ],
  );
}
