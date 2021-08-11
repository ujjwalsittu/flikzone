import 'package:flickzone/data/video_firebase.dart';
import 'package:flickzone/models/ShortVideo.dart';
import 'package:flickzone/widgets/ShortVideoWebServices.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class FeedViewModel extends BaseViewModel {
  List<ShortVideo>? _shortVideos = <ShortVideo>[];
  List<ShortVideo>? resp;
  void _loadShortVideo() async {
    resp = await ShortVideoWebService().loadAllLV();

    _shortVideos = resp;
  }

  VideoPlayerController? controller;

  int prevVideo = 0;

  int actualScreen = 0;

  changeVideo(index) async {
    if (_shortVideos![index].videoUrl == null) {
      _loadShortVideo();
    }
    _shortVideos![index].controller!.play();
    //videoSource.listVideos[prevVideo].controller.removeListener(() {});

    if (_shortVideos![prevVideo].controller != null)
      _shortVideos![prevVideo].controller!.pause();

    prevVideo = index;
    notifyListeners();

    print(index);
  }

  void loadVideo(int index) async {
    if (_shortVideos!.length > index) {
      await _shortVideos![index].loadController();
      _shortVideos![index].controller?.play();
      _shortVideos![index].controller?.setVolume(0);
      notifyListeners();
    }
  }

  void setActualScreen(index) {
    actualScreen = index;
    if (index == 0) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notifyListeners();
  }
}
