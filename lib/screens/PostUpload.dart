import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:advance_image_picker/advance_image_picker.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flickzone/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder_flutter/geocoder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class PostUpload extends StatefulWidget {
  const PostUpload({Key? key, required this.imageFile}) : super(key: key);
  final String imageFile;
  @override
  State<PostUpload> createState() => _PostUploadState();
}

class _PostUploadState extends State<PostUpload> {
  var _captionController;
  var _locationController;
  @override
  void initState() {
    super.initState();
    locateUser();
    _locationController = TextEditingController();
    _captionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _locationController?.dispose();
    _captionController?.dispose();
  }

  String _postPath = "";
  String _postFileName = "";
  String _postContent = "";
  bool _isFileSelected = false;
  double progress = 0;
  String locationData = "India";
  bool isUploading = false;
  TextEditingController _textEditingController = TextEditingController();
  List<ImageObject> _imgObjs = [];

  Future<String> uploadData() async {
    var box = Hive.box('OTP');
    int userid = box.get('userid');
    print(userid);
    var request = MultipartRequest(
      'POST',
      Uri.parse(kAppUrl + "/post/upload"),
      onProgress: (int bytes, int total) {
        final progres = bytes / total;
        print('progress: $progres ($bytes/$total)');
        setState(() {
          progress = progres;
        });
      },
    );

    request.files
        .add(await http.MultipartFile.fromPath('postImage', widget.imageFile));
    request.fields['userId'] = userid.toString();
    request.fields['categoryType'] = "1";
    request.fields['postContent'] = _postContent;
    request.fields['location'] = locationData;
    request.fields['hasImage'] = "1";
    final res = await request.send();

    print(res.statusCode);
    // print(res.stream);
    var responseString = await res.stream.bytesToString();
    final respon = jsonDecode(responseString);
    print(respon);
    if (respon["success"] == true) {
      setState(() {
        isUploading = false;
        _isFileSelected = false;
        _textEditingController.clear();
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            confirmBtnText: "Ohk",
            onConfirmBtnTap: () {
              Navigator.of(context).pop();
            },
            text: "Post Uploaded SuccessFully");
      });
    }
    return res.reasonPhrase!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("Create Post"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      uploadData();
                      isUploading = true;
                    });
                  },
                  child: Text(
                    "Share",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  )),
            ),
          ),
        ],
      ),
      body: _isFileSelected
          ? Container(
              height: MediaQuery.of(context).devicePixelRatio * 100,
              width: MediaQuery.of(context).devicePixelRatio * 100,
              child: Image.file(
                File(_postPath),
                fit: BoxFit.contain,
              ),
            )
          : Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(widget.imageFile),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                        child: TextField(
                          controller: _captionController,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Write a caption...',
                          ),
                          onChanged: ((value) {
                            setState(() {
                              _captionController.text = value;
                              _postContent = value;
                            });
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _locationController,
                    onChanged: ((value) {
                      setState(() {
                        _locationController.text = value;
                        locationData = value;
                      });
                    }),
                    decoration: InputDecoration(
                      hintText: 'Add location',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: FutureBuilder(
                      future: locateUser(),
                      builder:
                          ((context, AsyncSnapshot<List<Address>> snapshot) {
                        //  if (snapshot.hasData) {
                        if (snapshot.hasData) {
                          return Row(
                            // alignment: WrapAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                child: Chip(
                                  label: Text(snapshot.data!.first.locality!),
                                ),
                                onTap: () {
                                  setState(() {
                                    _locationController.text =
                                        snapshot.data!.first.locality!;
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: GestureDetector(
                                  child: Chip(
                                    label: Text(
                                        snapshot.data!.first.subAdminArea! +
                                            ", " +
                                            snapshot.data!.first.subLocality!),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _locationController.text =
                                          snapshot.data!.first.subAdminArea! +
                                              ", " +
                                              snapshot.data!.first.subLocality!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        } else {
                          print(
                              "Connection State : ${snapshot.connectionState}");
                          return CircularProgressIndicator();
                        }
                      })),
                ),
              ],
            ),
      // SingleChildScrollView(
      //   child: Stack(
      //     children: [
      //       Column(
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.all(16.0),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 // _isFileSelected
      //                 //     ? Image.file(
      //                 //         File(_postPath),
      //                 //         // fit: BoxFit.fitWidth,
      //                 //         scale: 4.5,
      //                 //       )
      //                 //     : Image.network(
      //                 //         kDefaultPic,
      //                 //         scale: 1.5,
      //                 //         // fit: BoxFit.fitWidth,
      //                 //       ),
      //               ],
      //             ),
      //           ),
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
      //                     ? Text(
      //                         _postFileName,
      //                         overflow: TextOverflow.ellipsis,
      //                       )
      //                     : Text("No File Selected, Select a File"),
      //               ],
      //             ),
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               GestureDetector(
      //                 onTap: () async {
      //                   List<ImageObject>? objects = await Navigator.of(context)
      //                       .push(PageRouteBuilder(
      //                           pageBuilder: (context, animation, __) {
      //                     return const ImagePicker(
      //                         maxCount: 2, isCaptureFirst: true);
      //                   }));
      //
      //                   if ((objects?.length ?? 0) > 0) {
      //                     setState(() {
      //                       _imgObjs = objects!;
      //                     });
      //                   }
      //                 },
      //                 child: Icon(
      //                   Icons.camera,
      //                   size: 50,
      //                   color: Colors.pinkAccent,
      //                 ),
      //               )
      //             ],
      //           ),
      //           ElevatedButton(
      //             onPressed: () async {
      //               FilePickerResult? result =
      //                   await FilePicker.platform.pickFiles(
      //                 type: FileType.image,
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
      //           TextFormField(
      //             onChanged: (value) {
      //               setState(() {
      //                 _postContent = value;
      //               });
      //             },
      //             controller: _textEditingController,
      //             decoration: InputDecoration(
      //                 icon: Icon(Icons.short_text_sharp),
      //                 labelText: "Post Description",
      //                 hintText: "Enter Post Description"),
      //           ),
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

  Future<List<Address>> locateUser() async {
    LocationData currentLocation;
    Future<List<Address>> addresses;
    var status = await Permission.locationWhenInUse.status;
    if (status.isDenied) {
      await Permission.locationWhenInUse.shouldShowRequestRationale;
    }

    var location = new Location();
    currentLocation = await location.getLocation();

    print(
        'LATITUDE : ${currentLocation.latitude} && LONGITUDE : ${currentLocation.longitude}');

    // From coordinates
    final coordinates =
        new Coordinates(currentLocation.latitude, currentLocation.longitude);

    addresses = Geocoder.local.findAddressesFromCoordinates(coordinates);

    return addresses;
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
