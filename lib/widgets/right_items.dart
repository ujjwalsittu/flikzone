// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class RightItems extends StatelessWidget {
//   final String comments;
//   final String userImg;
//   final String coverImg;
//   final String noOfLikes;
//
//
//   const RightItems(
//       {required this.comments,
//       required this.userImg,
//       required this.coverImg,
//       required this.noOfLikes});
//
//   @override
//   Widget build(BuildContext context) {
//     // FlutterMoneyFormatter fmf =
//     // FlutterMoneyFormatter(amount: double.parse(favorite.toString()));
//     Color heartColor = Colors.white;
//     return Align(
//       alignment: Alignment.bottomRight,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           userLogo(),
//           SizedBox(height: 12.0),
//           customIcon(Icons.favorite, noOfLikes),
//           customIcon(Icons.insert_comment, comments),
//           customIcon(FontAwesomeIcons.share, "Share"),
//           SizedBox(height: 40.0),
//           musicLogo(),
//         ],
//       ),
//     );
//   }
//
//   Widget userLogo() {
//     return Container(
//       height: 50.0,
//       width: 50.0,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.circle,
//         image: DecorationImage(
//           image: NetworkImage(userImg),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
//
//   Widget customIcon(IconData ico, String title) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Icon(ico, color: Colors.white ? Colors.red : Colors.white , size: 40.0),
//         SizedBox(height: 5.0),
//         Text(
//           title,
//           style: TextStyle(color: Colors.white),
//         ),
//         SizedBox(height: 10.0)
//       ],
//     );
//   }
//
//   Widget musicLogo() {
//     return Container(
//       height: 60.0,
//       width: 60.0,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//       ),
//       child: AvatarGlow(
//         glowColor: Colors.black,
//         endRadius: 35.0,
//         child: Container(
//           width: 30.0,
//           height: 30.0,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             image: DecorationImage(
//                 image: NetworkImage(coverImg), fit: BoxFit.cover),
//           ),
//         ),
//       ),
//     );
//   }
// }
