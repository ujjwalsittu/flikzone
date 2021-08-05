import 'package:flickzone/models/notificationsModel.dart';
import 'package:flickzone/models/postModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String kAppName = "Flickzone";
String kAppUrl = "apiv1.flikzone.com:4000";
String twilioSID = "AC77e0042bdbe399eecec9adde871463d3";
String twilioToken = "b4f009a1e5911c34945f3914e97cfd39";
String twilioNumber = "+16067555554";
String otpMessage = "Your OTP To Login is : ";
String kDefaultPic =
    "https://image.flaticon.com/icons/png/512/3237/3237472.png";

const kImageUrls = [
  "https://images.unsplash.com/photo-1623449658404-c506199c340d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=401&q=80",
  "https://images.unsplash.com/photo-1583912086296-be5b665036d3?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2FtcGxlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1576086213369-97a306d36557?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8c2FtcGxlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1601961545517-59307b1fbac3?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8c2FtcGxlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1579684256060-d5a308109e21?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8c2FtcGxlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1583912267550-d974311a9a6e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8c2FtcGxlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1578496479939-722d9dd1cc5b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNhbXBsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1582719201952-ea63ac1671dc?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fHNhbXBsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1583911860205-72f8ac8ddcbe?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHNhbXBsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1578496781329-41da6c97ffc4?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjh8fHNhbXBsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
];

const kPartyImg = [
  "https://images.unsplash.com/photo-1528495612343-9ca9f4a4de28?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=667&q=80",
  "https://images.unsplash.com/photo-1496024840928-4c417adf211d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
  "https://images.unsplash.com/photo-1501238295340-c810d3c156d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80",
  "https://images.unsplash.com/photo-1536940385103-c729049165e6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=373&q=80",
  "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
  "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=667&q=80",
  "https://images.unsplash.com/photo-1519671482749-fd09be7ccebf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80",
  "https://images.unsplash.com/photo-1523301343968-6a6ebf63c672?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
];
const kQuarantineImg = [
  "https://images.unsplash.com/photo-1588605241863-782146b51365?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=282&q=80",
  "https://images.unsplash.com/photo-1611666181038-bdd8f7248ddb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=282&q=80",
  "https://images.unsplash.com/photo-1588811752802-af42bad9f378?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=282&q=80",
  "https://images.unsplash.com/photo-1589476993526-4b4317f5e188?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=282&q=80",
  "https://images.unsplash.com/photo-1586012606305-b874330e25fc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=667&q=80",
  "https://images.unsplash.com/photo-1586012452971-f2606a5799f7?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=667&q=80",
  "https://images.unsplash.com/photo-1605565348518-bef3e7d6fed8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=755&q=80",
  "https://images.unsplash.com/photo-1594982734080-a79967e10c50?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=375&q=80",
];

List<NotificationModel> kNotifications = [
  NotificationModel(
      name: "Harry",
      faceUrl:
          "https://images.unsplash.com/photo-1571224736343-7182962ae3e7?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80",
      time: "2h",
      icon: FontAwesomeIcons.plus,
      message: "You have a new follower"),
  NotificationModel(
      name: "Meg",
      faceUrl:
          "https://images.unsplash.com/photo-1604874156629-5c6c3b3bded7?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
      time: "3h",
      icon: FontAwesomeIcons.star,
      message: "Liked Your Video"),
  NotificationModel(
      name: "Filipp",
      faceUrl:
          "https://images.unsplash.com/photo-1616162964877-ffdfcd7d0a1a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
      time: "18h",
      icon: FontAwesomeIcons.star,
      message: "Liked Your Videp"),
  NotificationModel(
      name: "Den",
      faceUrl:
          "https://images.unsplash.com/photo-1623113588779-fb2e1191aeaf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80",
      time: "24h",
      icon: FontAwesomeIcons.plus,
      message: "You have a new follower"),
  NotificationModel(
      name: "Joecalih",
      faceUrl:
          "https://images.unsplash.com/photo-1623135679170-27936642b80e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80",
      time: "24h",
      icon: FontAwesomeIcons.plus,
      message: "You have a new follower"),
  NotificationModel(
      name: "Felipe",
      faceUrl:
          "https://images.unsplash.com/photo-1582418701181-fb023bad8b4d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=358&q=80",
      time: "24h",
      icon: FontAwesomeIcons.star,
      message: "Liked Your Video"),
  NotificationModel(
      name: "Alexis",
      faceUrl:
          "https://images.unsplash.com/photo-1512849934327-1cf5bf8a5ccc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
      time: "1 Day",
      icon: FontAwesomeIcons.star,
      message: "Liked Your Video"),
  NotificationModel(
      name: "Abdulla",
      faceUrl:
          "https://images.unsplash.com/photo-1623153611623-6b8a4bc4fb69?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=889&q=80",
      time: "1day 2h",
      icon: FontAwesomeIcons.star,
      message: "Liked Your Video"),
  NotificationModel(
      name: "Sammy",
      faceUrl:
          "https://images.unsplash.com/photo-1623038455007-891466ff6016?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80",
      time: "2day",
      icon: FontAwesomeIcons.star,
      message: "Liked Your Video"),
  NotificationModel(
      name: "Jade",
      faceUrl:
          "https://images.unsplash.com/photo-1623038455007-891466ff6016?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80",
      time: "3day",
      icon: FontAwesomeIcons.star,
      message: "Liked Your Video"),
];

const kTaImageUrl = {
  'http://lorempixel.com/200/200/food/1',
  'http://lorempixel.com/200/200/food/2',
  'http://lorempixel.com/200/200/food/3',
  'http://lorempixel.com/200/200/food/4',
  'http://lorempixel.com/200/200/food/5',
  'https://picsum.photos/id/1/200/300',
};

const imageurl = "https://picsum.photos/id/";

const List items = [
  {
    "videoUrl":
        "https://cdn.mitron.tv/upload/video/J0rlNjB8Jh7xmz3ul.mp4?did=0665d2fb-3579-470b-b3e8-0ca83909f7f5&os=desktop&appversion=1.2.26&Expires=1623600629&Signature=eheLpinpUH8wlqQSl7ScO4I1WHV1SrmwGg4BXSFK7oLNVfXUyeTNzUu3b3u-GcHPLeM2TyuRxeL4Z0REEM0dySvH9WxTN17aV22j47fddaXfrJb1kCqwLUfTNLYWi9nZSX524jrNy1d1wcZnWjxPygL0q~gpssfbuChl93lbRzaWKefdD1IMTyQjQvq5NsLdBKWZyf8mLcJh6~g-GJQ2lFxD5TGyru95p3Ng5CmNqCRrY7oReq5zJ0JwWNhdJ9RyGoQnw65mc8RzvVeqFtDBJbO78f3etfuofyimM5FyKly-v733Yl5wWgRyrqqMiC-u7i2fuN8m3rsReazOp3hAFA__&Key-Pair-Id=APKAJC5IR22FDUYEWMWA",
    "name": "Prachi Shah",
    "caption": "Morning, everyone!!",
    "songName": "original sound - Prachi Shah",
    "profileImg":
        "https://cdn.mitron.tv/profile_pic/r0eaJbZNnhEweQmu2z.jpg?d=300x300",
    "likes": "1.5M",
    "comments": "18.9K",
    "shares": "80K",
    "albumImg": "https://web.mitron.tv/images/music3.gif"
  },
  {
    "videoUrl":
        "https://cdn.mitron.tv/upload/video/NYb0oRK6KUJOkBgTno.mp4?did=0665d2fb-3579-470b-b3e8-0ca83909f7f5&os=desktop&appversion=1.2.26&Expires=1623600749&Signature=N9FTE-~LdX3OgXgJP8rpO2-KBa--8vTo0IWZUV-Byx7Fc7imbmXaer7Pbeob7JlsjYvTA4sfOQAtsugpwYYf-m8cSjzik1UZ68iK6Io~3iR8t7OcpyFKwup1i~srEp4fXn3QZ6WgYC21G6gf24sMZCZJiSSRI-8QBzuD-WWMWlr0~dNzqUFDwcrjfufwLHrZ92ewbretoNGoS47zy0nCOZrlrlktRX-jfulV2Qd6MUoruWKTmjJRlFF6QHSp4RHFgBHtyVEIDBVkohnsT-Fb3A~S1btRY6tMcfmZEJZUpIebYbpp3dmUlDvsBQL0VSrZ2O3e4IpjdtBZA~W63NnzLQ__&Key-Pair-Id=APKAJC5IR22FDUYEWMWA",
    "name": "Maitri",
    "caption": "Oops 🙊 #fyp #cambodiatiktok",
    "songName": "original sound - Maitri",
    "profileImg":
        "https://cdn.mitron.tv/profile_pic/gY8RQOGwBtbRLxBI7n.jpg?d=300x300",
    "likes": "4.4K",
    "comments": "5.2K",
    "shares": "100",
    "albumImg": "https://web.mitron.tv/images/music3.gif"
  },
  {
    "videoUrl":
        "https://cdn.mitron.tv/upload/video/qPM8Lx2V8F6RGqQUnG.mp4?did=0665d2fb-3579-470b-b3e8-0ca83909f7f5&os=desktop&appversion=1.2.26&Expires=1623600858&Signature=Md3DUOI9lNshfBkM1WJYBVJP5uI02qDMiW8a4p-PR-y7cE4r0E5Mt-MWzUMBSNXWY4PV3jmZe~IZXzUxYmfU1fuKwTPjxjhtbEorKFwDngk7wJmo079SG5QHPw-AzTG8Q387XHaknvJhLaJoDuylBS40ZBcQrOPHoF7l0c4pcmfhpqOVE~~8ZfRAhnXHWmFoIerQHsSGf1OE07EPwWJEcrasdRIuZpQbBt3haNF7~PcAAwIZ-Ngq1suXB32lHLgpLQpyaoVx9rK6ZCnWsNJZzIxKmBSEfqgLbiS~AEr~Urpok5H-tteGwQ2MTeyBFsCkIEQXwm6QbL5ITRr7Lzf9vg__&Key-Pair-Id=APKAJC5IR22FDUYEWMWA",
    "name": "theyogagirl",
    "caption": "Elbow Stand #ELBOWWWWW",
    "songName": "original sound - theyyogagirl",
    "profileImg":
        "https://cdn.mitron.tv/profile_pic/1598117081803_JmJ0lbZd0ILAwG4wf2a0.jpg?d=300x300",
    "likes": "100K",
    "comments": "10K",
    "shares": "8.5K",
    "albumImg": "https://web.mitron.tv/images/music3.gif"
  },
];

const appBgColor = Color(0xFF000000);
const primary = Color(0xFFFC2D55);
const secondary = Color(0xFF19D5F1);
const white = Color(0xFFFFFFFF);
const black = Color(0xFF000000);

List<PostModel> kPosts = [];
