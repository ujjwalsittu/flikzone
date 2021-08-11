// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:velocity_x/velocity_x.dart';
//
// class SinglePostScreen extends StatefulWidget {
//   @override
//   State<SinglePostScreen> createState() => _SinglePostScreenState();
// }
//
// class _SinglePostScreenState extends State<SinglePostScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Vx.gray300,
//         title: "Post".text.gray700.make(),
//         iconTheme: IconThemeData(color: Vx.black),
//         actionsIconTheme: IconThemeData(color: Vx.black),
//         centerTitle: true,
//       ),
//       body:  Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     new Container(
//                       height: 40.0,
//                       width: 40.0,
//                       decoration: new BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: new DecorationImage(
//                             fit: BoxFit.fill,
//                             image: new NetworkImage(
//                                 _posts![index].profilepic.toString())),
//                       ),
//                     ),
//                     new SizedBox(
//                       width: 10.0,
//                     ),
//                     new Text(
//                       _posts![index].username.toString(),
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     )
//                   ],
//                 ),
//                 new IconButton(
//                   icon: Icon(Icons.more_vert),
//                   onPressed: null,
//                 )
//               ],
//             ),
//           ),
//           _posts![index].hasImage == 1
//               ? Flexible(
//             fit: FlexFit.loose,
//             child: new Image.network(
//               kAppUrl + "/" + _posts![index].postImage.toString(),
//               fit: BoxFit.cover,
//             ),
//           )
//               : SizedBox(
//             height: 1,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 FaIcon(
//                   Icons.favorite,
//                   color: Vx.red500,
//                 ),
//                 Text(_posts![index].noOfLikes.toString() + " people liked this")
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
//             child: Text(
//                 DateTime.parse(_posts![index].createdOn.toString())
//                     .timeAgo(enableFromNow: true, useShortForm: false)
//                     .firstLetterUpperCase(),
//                 style: TextStyle(color: Colors.grey)),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 // ignore: unnecessary_new
//                 new IconButton(
//                   icon: _posts![index].isLiked == 1
//                   // ignore: prefer_const_constructors
//                       ? FaIcon(
//                     Icons.favorite,
//                     color: Vx.red500,
//                   )
//                   // ignore: prefer_const_constructors
//                       : FaIcon(
//                     Icons.favorite_border,
//                     color: Vx.gray500,
//                   ),
//                   onPressed: () {
//                     var box = Hive.box('OTP');
//                     int myid = box.get("userid");
//                     String contentId = _posts![index].id.toString();
//                     setState(() {
//                       if (_posts![index].isLiked == 1) {
//                         final url =
//                             "http://15.207.105.12:4040/likesanddislikes/delete/" +
//                                 contentId +
//                                 "/" +
//                                 myid.toString();
//                         print(url);
//                         Dio().delete(url);
//                       } else {
//                         FormData formData = FormData.fromMap({
//                           "userID": myid,
//                           "isPostLike": 1,
//                           "contentId": contentId
//                         });
//                         try {
//                           var response = Dio().post(
//                               "http://15.207.105.12:4040/likesanddislikes/upload",
//                               data: formData);
//                           // print(response!.data);
//                           print("Likes Working");
//                         } on DioError catch (e) {
//                           print(e.response!.statusCode);
//                         }
//                       }
//                     });
//                   },
//                 ),
//                 // ignore: unnecessary_new
//                 new SizedBox(
//                   child: "|".text.make(),
//                   width: 16.0,
//                 ),
//                 const Icon(
//                   FontAwesomeIcons.comment,
//                 ),
//                 // ignore: unnecessary_new
//                 new SizedBox(
//                   child: "|".text.make(),
//                   width: 16.0,
//                 ),
//                 // ignore: unnecessary_new
//                 new VxContinuousRectangle(
//                   height: 40,
//                   width: 50,
//                   backgroundColor: Vx.white,
//                   // ignore: prefer_const_constructors
//                   backgroundImage: DecorationImage(
//                     // ignore: prefer_const_constructors
//                     image: AssetImage("assets/images/flick.png"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 new Container(
//                   height: 40.0,
//                   width: 40.0,
//                   decoration: new BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: new DecorationImage(
//                       fit: BoxFit.fill,
//                       image: new NetworkImage(
//                           _posts![index].profilepic.toString()),
//                     ),
//                   ),
//                 ),
//                 new SizedBox(
//                   width: 10.0,
//                 ),
//                 Expanded(
//                   child: new TextField(
//                     decoration: new InputDecoration(
//                       border: InputBorder.none,
//                       enabled: false,
//                       hintText: "Add a comment...",
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             child: VxContinuousRectangle(
//               height: 10,
//               backgroundColor: Vx.gray200,
//             ),
//           )
//         ],
//       );
//     );
//   }
// }
