import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:advance_image_picker/advance_image_picker.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flickzone/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geocoder_flutter/geocoder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class ShortVideoUploadScreen extends StatefulWidget {
  const ShortVideoUploadScreen({Key? key, required this.imageFile})
      : super(key: key);
  final String imageFile;

  @override
  _ShortVideoUploadScreenState createState() => _ShortVideoUploadScreenState();
}

class _ShortVideoUploadScreenState extends State<ShortVideoUploadScreen> {
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
