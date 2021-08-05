import 'package:flickzone/constants.dart';
import 'package:flutter/material.dart';

class FirstTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return GridTile(
              child: Container(
                child: Image.network(imageurl + "${index + 1}/200/300"),
              ),
            );
          },
          itemCount: 20,
        ),
      ),
    );
  }
}
