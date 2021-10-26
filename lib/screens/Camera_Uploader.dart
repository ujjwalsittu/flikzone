import 'package:camera_roll_uploader/camera_roll_uploader.dart';
import 'package:flickzone/screens/PostUpload.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Picker extends StatefulWidget {
  const Picker({Key? key}) : super(key: key);

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  String imagePathh = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select"),
        backgroundColor: Colors.grey,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
                child: GestureDetector(
              onTap: () {
                if (imagePathh == "0") {
                  VxToast.show(context, msg: "Please Select A  Image");
                } else {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (_) => PostUpload(imageFile: imagePathh)));
                }
              },
              child: Text(
                "Next",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).devicePixelRatio * 7),
              ),
            )),
          ),
        ],
      ),
      body: CameraRollUploader(selectedImageCallback: (imagePath) {
        print("imagePath $imagePath");
        setState(() {
          imagePathh = imagePath;
        });
      }),
    );
  }
}
