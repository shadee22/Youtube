// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  const Video({Key? key}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  _controller!.seekTo(Duration(seconds: _controller!.value.position.inSeconds + 1));
                },
                icon: Icon(Icons.seven_k))
          ],
        ),
        body: Center(
          child: _controller!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                )
              : CircularProgressIndicator(
                  color: Colors.black,
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(_controller!.value.position.inSeconds);
            setState(() {
              _controller!.value.isPlaying
                  ? _controller!.pause()
                  : _controller!.play();
            });
          },
          child: Icon(
            _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }
}
