import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:video_player/video_player.dart';

class VideoRecorderController extends ControllerMVC {
  CameraController? controller;
  String videoPath = "";
  String audioFile = "";
  String description = "";
  List<CameraDescription>? cameras;

  late int selectedCameraIdx;
  bool videoRecorded = false;
  GlobalKey<FormState> key = new GlobalKey();
  // bool _validate = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();
  final FlutterFFmpegConfig _flutterFFmpegConfig = new FlutterFFmpegConfig();
  bool showRecordingButton = false;
  bool isUploading = false;
  bool isProcessing = false;
//  Subscription _subscription;
  double uploadProgress = 0;
  bool saveLocally = true;
  VideoPlayerController? videoController;
  VoidCallback? videoPlayerListener;
  String thumbFile = "";
  String gifFile = "";
  String watermark = "";
  int userId = 0;
  PanelController pc1 = new PanelController();
  String appToken = "";
  final assetsAudioPlayer = AssetsAudioPlayer();
  String audioFileName = "";
  int audioId = 0;
  int videoId = 0;
  bool showLoader = false;
  bool isPublishPanelOpen = false;
  bool isVideoRecorded = false;
  double videoProgressPercent = 0;
  bool showProgressBar = false;
  double progress = 0.0;
  late Timer timer;
  // AudioCache audioCache = AudioCache();
  // AudioPlayer advancedPlayer = AudioPlayer();
  late String responsePath;
  double videoLength = 15.0;

  bool cameraCrash = false;

  /// stop icon animation
  AnimationController? animationController;
  Animation? sizeAnimation;
  bool reverse = false;
  bool isRecordingPaused = false;
  int seconds = 1;

  int privacy = 0;

  String thumbPath = "";
  String gifPath = "";

  ValueNotifier<DateTime> endShift = ValueNotifier(DateTime.now());

  late DateTime pauseTime;
  late DateTime playTime;

  ValueNotifier<List<double>> videoTimerLimit = new ValueNotifier([]);
  VideoRecorderController() {
    initCamera();
  }
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void dispose() {
    super.dispose();
  }

  initCamera() {
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras!.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
          print(1111);
        });

        onCameraSwitched(cameras![selectedCameraIdx]).then((void v) {});
      }
    }).catchError((err) {
      print("::::::::::::::");
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  String validateDescription(String value) {
    if (value.length == 0) {
      return "Description is required!";
    } else {
      return "";
    }
  }

  // loadWatermark() {
  //   videoRepo.getWatermark().then((value) async {
  //     if (value != '') {
  //       // value = value.replaceAll('https://', 'http://');
  //       var file = await DefaultCacheManager().getSingleFile(value);
  //       setState(() {
  //         // watermark = value;
  //         watermark = file.path;
  //       });
  //       print("watermark file");
  //       print(watermark);
  //     }
  //   });
  // }

  Future<void> onCameraSwitched(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }

    if (audioFileName == "") {
      controller = CameraController(
        cameraDescription,
        ResolutionPreset.high,
        enableAudio: true,
        // enableAudio: true,
      );
    } else {
      controller = CameraController(
        cameraDescription,
        ResolutionPreset.high,
        enableAudio: true,
        // enableAudio: false,
      );
    }
    // If the controller is updated then update the UI.
    controller!.addListener(() {
      if (controller!.value.hasError) {
        print('Camera error ${controller!.value.errorDescription}');
        /*Fluttertoast.showToast(
            msg: 'Camera error ${controller.value.errorDescription}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white);*/
      }
    });

    try {
      print("Initailise Camera Now");
      await controller!.initialize();
      await controller!.setFlashMode(FlashMode.off);
      await controller!.lockCaptureOrientation(DeviceOrientation.portraitUp);
    } on CameraException catch (e) {
      print("Exp:" + e.toString());
      //showCameraException(e, context);
    }

    setState(() {});
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 18.0,
            ),
            margin: EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: Color(0xff2e2f34),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                    child: Container(
                  height: 80,
                  width: 80,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("assets/icons/camera-error.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ) //
                    ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: new Text("Camera Error",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xfff5ae78),
                          fontWeight: FontWeight.bold)),
                ) //
                    ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: new Text("Camera Stopped Wroking !!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      )),
                ) //
                    ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RaisedButton(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [Color(0xffec4a63), Color(0xff7350c7)],
                        begin: FractionalOffset(0.0, 1),
                        end: FractionalOffset(0.4, 4),
                        stops: [0.1, 0.7],
                      )),
                      child: Center(
                        child: Text(
                          'Exit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'RockWellStd',
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // videoRepo.homeCon.value.getVideos();
                      // Navigator.of(context).pushReplacementNamed(
                      //   '/redirect-page',
                      //   arguments: 0,
                      // );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showCameraException(CameraException e, BuildContext context) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);
    setState(() {
      cameraCrash = true;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
    /*Fluttertoast.showToast(
        msg: 'Error: ${e.code}\n${e.description}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);*/
  }

  void onSwitchCamera() {
    // print('asdasd');
    selectedCameraIdx =
        selectedCameraIdx < cameras!.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras![selectedCameraIdx];

    onCameraSwitched(selectedCamera);

    setState(() {
      selectedCameraIdx = selectedCameraIdx;
    });
  }

  void onRecordButtonPressed(BuildContext context) {
    setState(() {
      isVideoRecorded = true;
      videoRecorded = true;
      isRecordingPaused = false;
    });
    startVideoRecording(context).whenComplete(() {
      print("startVideoRecording123");
      setState(() {
        showProgressBar = true;
        startTimer(context);

        assetsAudioPlayer.setVolume(0.6);
        assetsAudioPlayer.play();
      });
    });
  }

  /*Future<String> getSound(soundId) async {
    print("getSound");
    print(soundId);
    print("UserTokens $userId $appToken");
    setState(() {
//      showLoader = true;
    });
    try {
      String apiUrl = apiUrlRoot + "api/v1/get-sound";
      var response = await Dio().post(
        apiUrl,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'USER': apiUser,
            'KEY': apiKey,
          },
        ),
        queryParameters: {
          "sound_id": soundId,
          "user_id": userId,
          "app_token": appToken,
        },
      );
      if (response.statusCode == 200) {
        print(response.data);
        if (response.data['status'] == 'success') {
          setState(() {
            var map = Map<String, dynamic>.from(response.data['data']);
            SoundsData sound = SoundsData.fromJSON(map);
            audioFileName = sound.sound;
            audioFile = sound.soundURL;
            audioId = sound.soundID;
            assetsAudioPlayer.open(
              Audio.network(sound.soundURL),
              autoStart: false,
            );
            showLoader = false;
          });
        } else {
          var msg = response.data['msg'];
          scaffoldKey.currentState.showSnackBar(
            Helper.toast(msg, Colors.red),
          );
        }
      }
      setState(() {
        showLoader = false;
      });
    } catch (e) {
      var msg = e;
      scaffoldKey.currentState.showSnackBar(
        Helper.toast(msg, Colors.red),
      );
      setState(() {
        showLoader = false;
      });
    }
    return responsePath;
  }*/

  willPopScope(context) async {
    if (isVideoRecorded == true) {
      return exitConfirm(context);
    } else {
      // videoRepo.homeCon.value.showFollowingPage.value = false;
      // videoRepo.homeCon.value.showFollowingPage.notifyListeners();
      // videoRepo.homeCon.value.getVideos();
      // Navigator.of(context).pushReplacementNamed('/redirect-page', arguments: 0);
      return Future.value(true);
    }
  }

  Future<String> downloadFile(uri, fileName) async {
    bool downloading;
    bool isDownloaded;
    late String progress;
    setState(() {
      downloading = true;
    });
    String savePath = await getFilePath(fileName);
    Dio dio = Dio();
    dio.download(
      uri.trim(),
      savePath,
      onReceiveProgress: (rcv, total) {
        print(
            'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');

        // setState(() {
        progress = ((rcv / total) * 100).toStringAsFixed(0);
        // });

        if (progress == '100') {
          // setState(() {
          isDownloaded = true;
          // });
        } else if (double.parse(progress) < 100) {}
      },
      deleteOnError: true,
    ).then((_) {
      // setState(() {
      if (progress == '100') {
        isDownloaded = true;
      }
      downloading = false;
      // });
    });
    return savePath;
  }

  //gets the applicationDirectory and path for the to-be downloaded file

  // which will be used to save the file to that path in the downloadFile method

  void exitConfirm(context) {
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Container(
        height: 210.0,
        width: 300.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          //color: Colors.white,
          borderRadius: BorderRadius.all(new Radius.circular(12.0)),
        ),
        child: Column(
          children: <Widget>[
            Container(
                height: 150,
                decoration: BoxDecoration(
                  //color: Color(0xff2e2f34),
                  borderRadius: BorderRadius.all(new Radius.circular(12.0)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset('assets/images/gif-logo.gif',
                            width: 80, fit: BoxFit.fill),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            "Do you really want to discard "
                            "the video?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop("Discard");
              },
              child: Container(
                  decoration: BoxDecoration(
                    //color: Color(0xff2e2f34),
                    borderRadius: BorderRadius.all(new Radius.circular(32.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () async {},
                          child: Container(
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(
                              gradient: Gradients.blush,
                              borderRadius:
                                  BorderRadius.all(new Radius.circular(5.0)),
                            ),
                            child: Center(
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'RockWellStd'),
                              ),
                            ),
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop("Discard");
                        },
                        child: Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                            gradient: Gradients.blush,
                            borderRadius:
                                BorderRadius.all(new Radius.circular(5.0)),
                          ),
                          child: Center(
                            child: Text(
                              "No",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'RockWellStd',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory? dir;
    if (!Platform.isAndroid) {
      print("iosappDirectory");
      dir = await getApplicationDocumentsDirectory();
      print(dir);
    } else {
      dir = await getExternalStorageDirectory();
    }
    path = '${dir!.path}/$uniqueFileName';

    return path;
  }

  Future uploadGalleryVideo() async {
    print("uploadGalleryVideo");
    File? file;
    final picker = ImagePicker();
    Directory? appDirectory;
//    final Directory appDirectory = await getApplicationDocumentsDirectory();
    if (!Platform.isAndroid) {
      print("iosappDirectory");
      appDirectory = await getApplicationDocumentsDirectory();
      print(appDirectory);
    } else {
      appDirectory = await getExternalStorageDirectory();
    }
    /*if (Platform.isIOS) {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      print("appDirectory");
    }*/
    final String outputDirectory = '${appDirectory!.path}/outputVideos';
    await Directory(outputDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String thumbImg = '$outputDirectory/${currentTime}.jpg';
    final String outputVideo = '$outputDirectory/${currentTime}.mp4';
    final String thumbGif = '$outputDirectory/${currentTime}.gif';
    print("videoLength");
    print(videoLength);
    final pickedFile = await picker.getVideo(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    // File file = await ImagePicker.pickVideo(
    //   source: ImageSource.gallery,
    // );

    if (file != null) {
      // await _trimmer.loadVideo(videoFile: file);
      // Navigator.of(scaffoldKey.currentContext).push(
      //   MaterialPageRoute(builder: (context) {
      //     return TrimmerView(
      //       trimmer: _trimmer,
      //       onVideoSaved: (output) async {
      //         setState(() {
      //           videoPath = output;
      //         });
      //         print("videoPath");
      //         Navigator.pop(context);
      //         setState(() {
      //           isProcessing = true;
      //         });
      //         if (watermark != "") {
      //           _flutterFFmpeg
      //               .execute("-i $videoPath -i $watermark -filter_complex 'overlay=W-w-5:5' -c:a copy -preset ultrafast $outputVideo")
      //               .then((rc) async {
      //             print("watermark done");
      //             print("$videoPath = $outputVideo");
      //             setState(() {
      //               videoPath = outputVideo;
      //             });
      //             _flutterFFmpeg.execute("-i $videoPath -ss 00:00:00.000 -vframes 1 $thumbImg").then((rc) async {
      //               setState(() {
      //                 thumbPath = thumbImg;
      //               });
      //               print("thumbPath $thumbPath $thumbImg");
      //               print(File(thumbImg).exists());
      //               /*_flutterFFmpeg
      //                   .execute(
      //                       "-i $videoPath vf scale=500:-1 -t 10 -r 10  -loop 0 $thumbGif")
      //                   .then((rc) async {
      //                 print("FFmpeg process exited with rcgif $rc");
      //                 setState(() {
      //                   gifPath = thumbGif;
      //                 });
      //               });*/
      //               setState(() {
      //                 isProcessing = false;
      //               });
      //               await _startVideoPlayer(videoPath);
      //               /*await uploadVideo(videoPath, thumbImg).then((value) {
      //                 if (value = true) {}
      //               })*/
      //             });
      //           });
      //         } else {
      //           _flutterFFmpeg.execute("-i $videoPath -ss 00:00:00.000 -vframes 1 $thumbImg").then((rc) async {
      //             setState(() {
      //               thumbPath = thumbImg;
      //             });
      //             print("thumbPath $thumbPath $thumbImg");
      //             print(File(thumbImg).exists());
      //             /*_flutterFFmpeg
      //                 .execute(
      //                     "-ss 0 -t 3 -i $videoPath -vf 'fps=10,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse' -loop 0 $thumbGif")
      //                 .then((rc) async {
      //               print("FFmpeg process exited with rcgif $rc");
      //               setState(() {
      //                 gifPath = thumbGif;
      //               });
      //             });*/
      //             setState(() {
      //               isProcessing = false;
      //             });
      //             await _startVideoPlayer(videoPath);
      //             /*await uploadVideo(videoPath, thumbImg).then((value) {
      //                 if (value = true) {}
      //               })*/
      //           });
      //         }
      //         /*_flutterFFmpeg
      //             .execute(
      //                 "-i $videoPath -ss 00:00:00.000 -vframes 1 $thumbImg")
      //             .then((rc) async {
      //           setState(() {
      //             thumbPath = thumbImg;
      //           });
      //           print("thumbPath $thumbPath $thumbImg");
      //           print(File(thumbImg).exists());
      //           _flutterFFmpeg
      //               .execute(
      //                   "-ss 0 -t 3 -i $videoPath -vf 'fps=10,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse' -loop 0 $thumbGif")
      //               .then((rc) async {
      //             print("FFmpeg process exited with rcgif $rc");
      //             setState(() {
      //               gifPath = thumbGif;
      //             });
      //           });
      //           await _startVideoPlayer(videoPath);
      //           */ /*await uploadVideo(videoPath, thumbImg).then((value) {
      //                 if (value = true) {}
      //               })*/ /*
      //         });*/
      //         String responseVideo = "";
      //         // responseVideo = await videoRepo.uploadVideo();
      //         if (responseVideo != "") {
      //           pc1.open();
      //         }
      //       },
      //       onSkip: () async {
      //         Navigator.pop(context);
      //         setState(() {
      //           videoPath = file.path;
      //         });
      //         print("skip video : $videoPath");
      //         await _startVideoPlayer(videoPath);
      //       },
      //       maxLength: videoLength,
      //       sound: audioFile,
      //       showSkip: false,
      //     );
      //   }),
      // );
    }
  }

  convertToBase(file) async {
    print("Inside Video conversion");
    List<int> vidBytes = await File(file).readAsBytes();
    String base64Video = base64Encode(vidBytes);
    print("Base 64 Video : -" + base64Video);
    return base64Video;
  }

  showLoaderSpinner() {
    return Center(
      child: Container(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  void onStopButtonPressed() {
    timer.cancel();
    // if (soundRepo.currentSound.value.soundId > 0) {
    assetsAudioPlayer.pause();
    // }
    setState(() {
      videoRecorded = false;
      isProcessing = true;
    });
    stopVideoRecording().then((String outputVideo) async {
      print("_loadingStreamCtrl.true");
//      _loadingStreamCtrl.sink.add(true);
//       if (mounted) setState(() {});
      if (outputVideo != null) {}
    });
  }

  Future<void> _startVideoPlayer(outputVideo) async {
    setState(() {
      showLoader = true;
    });
    print("outputVideo");
    print(outputVideo);
    final VideoPlayerController vController =
        VideoPlayerController.file(new File(outputVideo));

    videoPlayerListener = () {
      if (videoController != null && videoController!.value.size != null) {
        // Refreshing the state to update video player with the correct ratio.
        // if (mounted) setState(() {});
        videoController!.removeListener(videoPlayerListener!);
      }
    };
    vController.addListener(videoPlayerListener!);
    await vController.setLooping(true);
    await vController.initialize();
    await videoController?.dispose();
    // if (mounted) {
    setState(() {
//        imagePath = null;
      videoController = vController;
    });
    // }
    await vController.play();
    setState(() {
      showLoader = false;
    });
  }

  void onPauseButtonPressed(BuildContext context) {
    // if (soundRepo.currentSound.value.soundId > 0) {
    assetsAudioPlayer.pause();
    // }
    setState(() {
      isRecordingPaused = true;
      pauseTime = DateTime.now();
    });
    pauseVideoRecording(context).then((_) {
      // if (mounted)
      setState(() {
        videoRecorded = false;
        timer.cancel();
      });
      print("pauseTime $pauseTime");
      print("endShift ${endShift.value}");
    });
  }

  void onResumeButtonPressed(BuildContext context) {
    assetsAudioPlayer.play();

    // setState(() {
    playTime = DateTime.now();
    isRecordingPaused = false;
    // });
    try {
      endShift.value.add(Duration(
          milliseconds: playTime.difference(pauseTime).inMilliseconds));
      endShift.notifyListeners();
    } catch (e) {
      print("endShift.value error $e");
    }
    print("playTime.difference(pauseTime).inMilliseconds");
    print(playTime.difference(pauseTime).inMilliseconds);
    resumeVideoRecording(context).then((_) {
      // if (mounted)
      // setState(() {
      videoRecorded = true;
      startTimer(context);
      // });
      print("playTime $playTime");
      print("endShift ${endShift.value}");
    });
  }

  Future<void> startVideoRecording(BuildContext context) async {
    if (!controller!.value.isInitialized) {
      return null;
    }
    // assetsAudioPlayer.play();

    // Do nothing if a recording is on progress
    if (controller!.value.isRecordingVideo) {
      return null;
    }
    Directory? appDirectory;
//    final Directory appDirectory = await getApplicationDocumentsDirectory();
//    final Directory appDirectory = await getExternalStorageDirectory();
    if (!Platform.isAndroid) {
      print("iosappDirectory");
      appDirectory = await getApplicationDocumentsDirectory();
      print(appDirectory);
    } else {
      appDirectory = await getExternalStorageDirectory();
    }
    final String videoDirectory = '${appDirectory!.path}/Videos';
    await Directory(videoDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$videoDirectory/$currentTime.mp4';

    try {
      await controller!.startVideoRecording();
      print("on start videoLength");
      print(videoLength);
      print(DateTime.now().toUtc());

      endShift.value = DateTime.now().add(Duration(
          milliseconds: videoLength.toInt() * 1000 +
              int.parse((videoLength.toInt() / 15).toStringAsFixed(0)) * 104));
      endShift.notifyListeners();
      print("endShift ${endShift.value}");
      print(endShift.value.toUtc());
    } on CameraException catch (e) {
      showCameraException(e, context);
      return null;
    }
    // print(filePath);
    // return filePath;
  }

  Future<void> pauseVideoRecording(BuildContext context) async {
    if (!controller!.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller!.pauseVideoRecording();
    } on CameraException catch (e) {
      showCameraException(e, context);
      rethrow;
    }
  }

  Future<void> resumeVideoRecording(BuildContext context) async {
    if (!controller!.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller!.resumeVideoRecording();
    } on CameraException catch (e) {
      showCameraException(e, context);
      rethrow;
    }
  }

  // final Trimmer _trimmer = Trimmer();
  Future<String> stopVideoRecording() async {
    assetsAudioPlayer.pause();
//    advancedPlayer.pause();
    // _flutterFFmpegConfig.enableStatisticsCallback(statisticsCallback);
    if (!controller!.value.isRecordingVideo) {
      return "";
    }

    try {
      await controller!.stopVideoRecording().then((file) {
        videoPath = file.path;
      });
    } on CameraException catch (e) {
      showCameraException(e, scaffoldKey.currentContext!);
      return "";
    }
    Directory? appDirectory;
//    final Directory appDirectory = await getApplicationDocumentsDirectory();
    if (!Platform.isAndroid) {
      print("iosappDirectory");
      appDirectory = await getApplicationDocumentsDirectory();
      print(appDirectory);
    } else {
      appDirectory = await getExternalStorageDirectory();
    }
    /*if (Platform.isIOS) {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      print("appDirectory");
    }*/
    final String outputDirectory = '${appDirectory!.path}/outputVideos';
    await Directory(outputDirectory).create(recursive: true);
    /*final String currentTime =
        "$countVideos" + DateTime.now().millisecondsSinceEpoch.toString();*/
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String watermarkVideo = '$outputDirectory/${currentTime}1212.mp4';
    final String outputVideo = '$outputDirectory/$currentTime.mp4';
    final String thumbImg = '$outputDirectory/$currentTime.jpg';
    final String thumbGif = '$outputDirectory/${currentTime}.gif';

    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path;
    // String aFPath = '${appDirectory.path}/Audios/$audioFile';
    String responseVideo = "";
    print("videoPath");
    print(videoPath);

    return videoPath;
  }

  /* startTimer(BuildContext context) {
    timer = Timer.periodic(new Duration(milliseconds: 100), (timer) {
      setState(() {
        videoProgressPercent += 1 / (videoLength * 10);
        if (videoProgressPercent >= 1) {
          videoProgressPercent = 1;
        }
        if (DateTime.now().isAfter(endShift.value) && !isRecordingPaused) {
          print("timer complete");
          isProcessing = true;
          videoProgressPercent = 1;
          timer.cancel();
          onStopButtonPressed();
        }
      });
    });
  }*/
  startTimer(BuildContext context) {
    timer = Timer.periodic(new Duration(milliseconds: 100), (timer) {
      setState(() {
        videoProgressPercent += 1 / (videoLength * 10);
        if (videoProgressPercent >= 1) {
          print("timer complete");
          isProcessing = true;
          videoProgressPercent = 1;
          timer.cancel();
          onStopButtonPressed();
        }
      });
    });
  }

  void getTimeLimits() {
    print("getTimeLimits");
    videoTimerLimit.value.add(double.parse("15"));

    videoTimerLimit.notifyListeners();
  }
}
