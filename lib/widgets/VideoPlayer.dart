import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:getwidget/getwidget.dart';

class TikTokVideoPlayer extends StatefulWidget {
  final String url;

  const TikTokVideoPlayer({required this.url});

  @override
  _TikTokVideoPlayerState createState() => _TikTokVideoPlayerState();
}

class _TikTokVideoPlayerState extends State<TikTokVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('${widget.url}')
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.pause();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: double.infinity,
      child: _controller.value.isInitialized
          ? GestureDetector(
              onTap: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              ),
            )
          : loadingVideo(),
    );
  }

  Widget loadingVideo() => Container(
        color: Colors.black,
        child: Center(
          child: GFLoader(
            type: GFLoaderType.circle,
            loaderColorOne: Colors.blueAccent,
            loaderColorTwo: Colors.white,
            loaderColorThree: Colors.pink,
          ),
        ),
      );
}
