import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flickzone/constants.dart';
import 'package:flickzone/widgets/LongVideoWebService.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:video_compress/video_compress.dart';

// import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flickzone/models/videCategoryModel.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class LongVideoUpload extends StatefulWidget {
  const LongVideoUpload({Key? key}) : super(key: key);

  @override
  _LongVideoUploadState createState() => _LongVideoUploadState();
}

class _LongVideoUploadState extends State<LongVideoUpload> {
  String kpic = kDefaultPic;
  String kPath = "";
  String fileName = "";
  bool thumnailSelected = false;
  bool fileSelected = false;
  List<VideoCategoryModel> _vidCat = <VideoCategoryModel>[];
  String thumbnail = "";
  String lDesc = "";
  String title = "";
  Uint8List? imageFile;
  double progress = 0;
  String thumbFile = "";
  String thumbnailFile = "";
  var _selectedItem;
  bool _isUploading = false;
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  void initState() {
    super.initState();
    loadCategories();
  }

  void loadCategories() async {
    final resp = await LongVideoWebService().loadVideCat();
    setState(() {
      _vidCat = resp.toList();
    });
    print("_______");
    print(_vidCat.length);
    print("_______");
  }

  onChangeDropdownTests(selectedTest) {
    print(selectedTest);
    setState(() {
      _selectedItem = selectedTest;
    });
  }

  // void dispose() {
  //   super.dispose();
  //   // _controller;
  // }

  Future<String> uploadImage() async {
    var box = Hive.box('OTP');
    int userid = box.get('userid');
    print(userid);
    var request = MultipartRequest(
      'POST',
      Uri.parse(kAppUrl + "/video/upload"),
      onProgress: (int bytes, int total) {
        final progres = bytes / total;
        print('progress: $progres ($bytes/$total)');
        setState(() {
          progress = progres;
        });
      },
    );

    request.files.add(await http.MultipartFile.fromPath('videoUrl', kPath));
    request.files
        .add(await http.MultipartFile.fromPath('thumbnailUrl', thumbnail));
    request.files
        .add(await http.MultipartFile.fromPath('musicThumbNailUrl', thumbnail));
    request.fields['userId'] = userid.toString();
    request.fields['category'] = "1";
    request.fields['isLong'] = '1';
    request.fields['descrition'] = lDesc;
    request.fields['hasTags'] = "";
    request.fields['location'] = "India";
    request.fields['musicId'] = "1";
    request.fields['status'] = "0";
    request.fields['canCommnet'] = "1";
    request.fields['title'] = title;
    final res = await request.send();

    print(res.statusCode);
    print(res);
    print(res.stream);
    String responseString = await res.stream.bytesToString();

    final respon = jsonDecode(responseString);
    print(respon);
    if (respon["success"] == true) {
      setState(() {
        _isUploading = false;

        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Video Uploaded SuccessFully");
      });
    }
    return res.reasonPhrase!;
  }
  //
  // void convertThumbnsil() async {
  //   final uint8list = await VideoThumbnail.thumbnailData(
  //     video: kPath,
  //     imageFormat: ImageFormat.PNG,
  //
  //     maxWidth:
  //         0, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
  //     quality: 25,
  //   );
  //   final thumbFile = await VideoCompress.getFileThumbnail(kPath);
  //
  //   var downloadsPath = await AndroidPathProvider.downloadsPath;
  //   print(downloadsPath);
  //   setState(() {
  //     imageFile = uint8list!;
  //     print(File(fileName).writeAsBytes(imageFile!));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("Upload Long Video"),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _titleController,
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.title),
                        labelText: "Video Title",
                        hintText: "Enter Video Title",
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 35.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      autofocus: true,
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        label: Text("Description"),
                        hintText: "Enter Description Here",
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 35.0),
                        ),
                      ),
                      maxLines: 25,
                      minLines: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.attach_file_outlined),
                        fileSelected
                            ? Expanded(
                                child: Text(
                                  fileName,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            : Text("No File Selected Yet "),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.video,
                      );

                      if (result != null) {
                        PlatformFile file = result.files.first;

                        print(file.name);
                        // print(file.bytes);
                        print(file.size);
                        print(file.extension);
                        print(file.path);
                        setState(() {
                          kPath = file.path!;
                          fileName = file.name;
                          fileSelected = true;
                        });
                        // convertThumbnsil();
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: Text("Click To Select Video"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image),
                        thumnailSelected
                            ? Expanded(
                                child: Text(
                                  thumbnailFile,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            : Text("No Thumbnail Selected Yet "),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.image,
                      );

                      if (result != null) {
                        PlatformFile file = result.files.first;

                        print(file.name);
                        // print(file.bytes);
                        print(file.size);
                        print(file.extension);
                        print(file.path);
                        setState(() {
                          thumbnail = file.path!;
                          thumbnailFile = file.name;
                          thumnailSelected = true;
                        });
                        // convertThumbnsil();
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: Text("Click To Select Video Thumbnail"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // TextButton(
                  //   onPressed: () async {
                  //     var res = await uploadImage();
                  //     setState(() {
                  //       // state = res;
                  //       print(res);
                  //     });
                  //   },
                  //   child: Text("Upload This Video"),
                  // ),
                ],
              ),
              _isUploading
                  ? Container(
                      width: MediaQuery.of(context).devicePixelRatio * 200,
                      height: MediaQuery.of(context).devicePixelRatio * 300,
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.pinkAccent,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: () async {
          setState(() {
            _isUploading = true;
          });
          var res = await uploadImage();

          setState(() {
            print(res);
          });
        },
        child: Text("Upload This Video"),
      ),
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
