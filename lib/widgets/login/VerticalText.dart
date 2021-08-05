/*
 * Copyright (c) 2021. All Rights Reserved, You are not allowed, distribute and modify this code under the terms of the of genric license issued by Musocial Private Limited. If any person / company wants to modify the code, he/she/they need to get developer license issued by Musocial Private Limited. If any person / company wants to distribute this code he/she/they need to get affliate / reseller license issued by Musocial Private Limited.
 * If any person / company is found to violate our copyright terms and licensing terms. we are completely liable to take legal actions under Copyright act, or any as per applicable by local law authorities.
 *
 * This code is documented and written by author : Ujjwal Kumar Sittu
 *
 */

import 'package:flutter/material.dart';

class VerticalText extends StatefulWidget {
  @override
  _VerticalTextState createState() => _VerticalTextState();
}

class _VerticalTextState extends State<VerticalText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 10),
      child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            'Join In',
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.w900,
            ),
          )),
    );
  }
}
