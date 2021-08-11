import 'package:flickzone/constants.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

String kMessage = "/message";

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Messages".text.make(),
        centerTitle: true,
        backgroundColor: Vx.gray500,
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: VxContinuousRectangle(
                backgroundColor: Vx.gray200,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(kDefaultPic),
                  ),
                  title: Text(
                    "Rohan",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: "Some Messages Here .......".text.xl.make(),
                  trailing: "Seen 1h ago".text.make(),
                ),
              ),
            );
          },
          itemCount: 8,
        ),
      ),
    );
  }
}
