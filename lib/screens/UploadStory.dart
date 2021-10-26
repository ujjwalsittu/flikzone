import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera_roll_uploader/camera_roll_uploader.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flickzone/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class StoryUpload extends StatefulWidget {
  const StoryUpload({Key? key}) : super(key: key);

  @override
  State<StoryUpload> createState() => _StoryUploadState();
}

class _StoryUploadState extends State<StoryUpload> {
  String _postPath = "";
  String _postFileName = "";
  String isImage = "1";
  bool _isFileSelected = false;
  double progress = 0;
  bool isUploading = false;
  bool fileUploaded = false;

  Future<String> uploadData() async {
    var box = Hive.box('OTP');
    int userid = box.get('userid');
    print(userid);
    var request = MultipartRequest(
      'POST',
      Uri.parse(kAppUrl + "/story/upload"),
      onProgress: (int bytes, int total) {
        final progres = bytes / total;
        print('progress: $progres ($bytes/$total)');
        setState(() {
          progress = progres;
        });
      },
    );

    request.files.add(await http.MultipartFile.fromPath('docUrl', _postPath));
    request.fields['userId'] = userid.toString();
    request.fields['isImage'] = isImage;

    final res = await request.send();
    print(res.statusCode);
    // print(res.stream);
    String responseString = await res.stream.bytesToString();
    final respon = jsonDecode(responseString);
    print(respon);
    if (respon["success"] == true) {
      setState(() {
        isUploading = false;
        _isFileSelected = false;
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            confirmBtnText: "Ok",
            text: "Story Uploaded SuccessFully",
            onConfirmBtnTap: () {
              Navigator.of(context).pop();
            });
      });
    }
    // if(responseString==true)
    print(responseString);
    print(respon);
    return res.reasonPhrase!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.blueGrey,
        title: Text("Add Story"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  if (_isFileSelected) {
                    uploadData();
                    isUploading = true;
                  } else {
                    VxToast.show(context, msg: "Tap on a image to select file");
                  }
                },
                child: Text(
                  "Post Story",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      body: isUploading
          ? Container(
              width: MediaQuery.of(context).devicePixelRatio * 200,
              height: MediaQuery.of(context).devicePixelRatio * 300,
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : CameraRollUploader(
              selectedImageCallback: (imagePath) {
                print("imagePath $imagePath");
                setState(() {
                  _postPath = imagePath;
                  _isFileSelected = true;
                });
              },
            ),

      // SingleChildScrollView(
      //   child: Stack(
      //     children: [
      //       Column(
      //         children: [
      //           _isFileSelected
      //               ? Container(
      //                   height: MediaQuery.of(context).devicePixelRatio * 100,
      //                   width: MediaQuery.of(context).devicePixelRatio * 100,
      //                   child: Image.file(
      //                     File(_postPath),
      //                     fit: BoxFit.contain,
      //                   ),
      //                 )
      //               : Text(""),
      //           Padding(
      //             padding: const EdgeInsets.all(16.0),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Icon(Icons.image_outlined),
      //                 _isFileSelected
      //                     ? Expanded(
      //                         child: Text(
      //                           _postFileName,
      //                           overflow: TextOverflow.ellipsis,
      //                         ),
      //                       )
      //                     : Text("No File Selected, Select a File"),
      //               ],
      //             ),
      //           ),
      //           ElevatedButton(
      //             onPressed: () async {
      //               FilePickerResult? result =
      //                   await FilePicker.platform.pickFiles(
      //                 type: FileType.media,
      //               );
      //
      //               if (result != null) {
      //                 PlatformFile file = result.files.single;
      //
      //                 print(file.name);
      //                 // print(file.bytes);
      //                 print(file.size);
      //                 print(file.extension);
      //                 print(file.path);
      //                 setState(() {
      //                   _postPath = file.path!;
      //                   _postFileName = file.name;
      //                   _isFileSelected = true;
      //                 });
      //                 // convertThumbnsil();
      //               } else {
      //                 // User canceled the picker
      //               }
      //             },
      //             child: Text("Select Image"),
      //           ),
      //           SizedBox(
      //             height: 10,
      //           ),
      //
      //           // ElevatedButton(
      //           //   onPressed: () async {
      //           //     var response = await uploadData();
      //           //
      //           //     setState(() {
      //           //       print(response.length);
      //           //     });
      //           //   },
      //           //   child: Text("Create Post"),
      //           // ),
      //         ],
      //       ),
      //       isUploading
      //           ? Container(
      //               width: MediaQuery.of(context).devicePixelRatio * 200,
      //               height: MediaQuery.of(context).devicePixelRatio * 300,
      //               color: Colors.black.withOpacity(0.5),
      //               child: Center(
      //                 child: CircularProgressIndicator(),
      //               ),
      //             )
      //           : Container()
      //     ],
      //   ),
      // ),
    );
  }
}

// multipart_request.dart

class MultipartRequest extends http.MultipartRequest {
  /// Creates a new [MultipartRequest].
  MultipartRequest(
    String method,
    Uri url, {
    required this.onProgress,
  }) : super(method, url);

  final void Function(int bytes, int totalBytes) onProgress;

  /// Freezes all mutable fields and returns a single-subscription [ByteStream]
  /// that will emit the request body.
  http.ByteStream finalize() {
    final byteStream = super.finalize();
    if (onProgress == null) return byteStream;

    final total = this.contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress(bytes, total);
        sink.add(data);
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}
