// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

// import 'dart:convert';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:spring/spring.dart';
import 'package:chewie/chewie.dart';
// import 'package:youtube/video.dart';

class Player extends StatefulWidget {
  String? hero;
  Player({this.hero});

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> with TickerProviderStateMixin {
  VideoPlayerController? _controller;
  SpringController? initSpring = SpringController(initialAnim: Motion.play);
  SpringController springController =
      SpringController(initialAnim: Motion.play);
  SpringController springback = SpringController(initialAnim: Motion.pause);
  SpringController springforward = SpringController(initialAnim: Motion.pause);

  pauseInit() {
    return initSpring!.play(motion: Motion.pause);
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
        // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
        'assets/10.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    _controller!.setLooping(true);
  }

  spacer() {
    return SizedBox(
      width: 10,
    );
  }

  final white = Colors.white;
  final hwhite = Colors.white.withOpacity(0.4);

  var iconList = [
    Icons.do_not_disturb_alt,
    Icons.playlist_add,
    Icons.share_outlined,
    Icons.download_done_outlined,
    Icons.report_gmailerrorred_outlined,
  ];

  List choiceList = [
    'Similar',
    'From This Man',
    'Related',
    'From Topic',
  ];

  bool fav = false;

  @override
  final red = Colors.redAccent;
  @override
  Widget build(BuildContext context) {
    ChewieController chewieController = ChewieController(
      allowFullScreen: false,
      videoPlayerController: _controller!,
      looping: false,
    );

    var device = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Row(
          children: [
            //minus
            Spring.rotate(
                animDuration: Duration(milliseconds: 300),
                springController: springback,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      seek_minus(_controller);
                      springController.play(motion: Motion.pause);
                      springback.play(motion: Motion.play);
                      springforward.play(motion: Motion.pause);
                    });
                  },
                  child: Row(children: [
                    Icon(
                      Icons.arrow_back_ios,
                    )
                  ]),
                )),
            spacer(),
            //plus
            Spring.rotate(
                animDuration: Duration(milliseconds: 300),
                springController: springforward,
                child: GestureDetector(
                    onTap: () {
                      seek_plus(_controller);

                      springController.play(motion: Motion.pause);
                      springforward.play(motion: Motion.play);
                      springback.play(motion: Motion.pause);
                    },
                    child: Row(children: [Icon(Icons.arrow_forward_ios)]))),
            spacer(),
            //playbutton
            Spring.bubbleButton(
              springController: springController,
              onTap: () {
                chewieController.togglePause();
                springforward.play(motion: Motion.pause);
                springback.play(motion: Motion.pause);
              },
              child: Row(
                children: [
                  Text(_controller!.value.isPlaying ? "Playing" : "Paused"),
                  Icon(_controller!.value.isPlaying
                      ? Icons.play_arrow_outlined
                      : Icons.pause_outlined),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: red,
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        toolbarHeight: 40,
        title: Text(
          "@SL_PROGRAMMER",
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.hero.toString(),
                  child: Container(
                    height: 241,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          fit: BoxFit.cover, image: AssetImage('assets/2.jpg')),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: _controller!.value.isInitialized
                            ? Chewie(
                                controller: chewieController,
                              )
                            // : CircularProgressIndicator(

                            //     color: Colors.black,
                            //   ),
                            : Container()),
                  ),
                ),
                // Positioned(
                //   bottom: 0,
                //   right: 5,
                //   child: Spring.bubbleButton(
                //     springController: springController,
                //     child: GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           playVideo(_controller, initSpring);
                //           springforward.play(motion: Motion.pause);
                //           springback.play(motion: Motion.pause);
                //         });
                //       },
                //       child: Container(
                //         margin: EdgeInsets.all(5),
                //         padding: EdgeInsets.all(5),
                //         decoration: BoxDecoration(
                //             color: Colors.black.withOpacity(0.5),
                //             borderRadius: BorderRadius.circular(10)),
                //         child: Icon(
                //           _controller!.value.isPlaying
                //               ? Icons.play_arrow_outlined
                //               : Icons.pause_outlined,
                //           color: Colors.white,
                //           size: 30,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // _controller!.value.isBuffering
                //     ? LinearProgressIndicator(
                //         backgroundColor: Colors.black,
                //       )
                //     : Container(),
                // _controller!.value.isInitialized
                //     ? Container()
                //     : Positioned(
                //         top: 10,
                //         left: 10,
                //         child: CircularProgressIndicator(
                //             backgroundColor: Colors.white, color: Colors.grey))
              ],
            ),
            Divider(),
            // Text('Video titile'),
            Text(
              'This Video Will Blow Your Mind ! | Mr.HappyT Mr.HappyT Mr.HappyT Mr.HappyTone | #223',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              color: hwhite,
            ),
            Spring.slide(
              springController: initSpring,
              slideType: SlideType.slide_in_right,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Spring.bubbleButton(
                    onTap: () {
                      setState(() {
                        fav = !fav;
                        pauseInit();
                      });
                    },
                    child: Icon(
                      fav == true ? Icons.favorite : Icons.favorite_outline,
                      size: 27,
                      color: fav == true ? red : Colors.white,
                    ),
                  ),
                  for (var i = 0; i < iconList.length; i++)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          fav = !fav;
                        });
                      },
                      icon: Icon(
                        iconList[i],
                        color: white,
                        size: 27,
                      ),
                    ),
                ],
              ),
            ),
            Divider(
              color: hwhite,
            ),
            Spring.slide(
              slideType: SlideType.slide_in_left,
              springController: initSpring,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.pink,
                  backgroundImage: AssetImage('assets/2.jpg'),
                ),
                title: Text(
                  "Mr.HappyTone",
                  style: TextStyle(
                      color: white.withOpacity(0.7),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "23M Subscribers",
                  style: TextStyle(color: white.withOpacity(0.4)),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    size: 28,
                    color: red,
                  ),
                ),
              ),
            ),
            Divider(
              color: hwhite,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (var i = 0; i < choiceList.length; i++)
                  ChoiceChip(
                    elevation: 0.0,
                    backgroundColor: Colors.red.withOpacity(0.4),
                    onSelected: (s) {},
                    selected: i == 0 ? true : false,
                    label: Text(
                      choiceList[i],
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
              ],
            ),
            Spring.slide(
              animDuration: Duration(milliseconds: 1500),
              slideType: SlideType.slide_in_right,
              withFade: true,
              springController: initSpring,
              child: Container(
                height: device.height - 20,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: [
                    for (var i = 0; i < 8; i++)
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/$i.jpg')),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: 70,
                              margin: EdgeInsets.all(5),
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.5),
                                    Colors.transparent,
                                    Colors.transparent
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Text(
                                "Tricky Man",
                                textAlign: TextAlign.center,
                                style: TextStyle(

                                    color: white, fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}

playVideo(_con, i) {
  _con!.value.isPlaying ? _con!.pause() : _con!.play();
  i.play(motion: Motion.pause);
}

seek_plus(_con) {
  return _con!.seekTo(Duration(seconds: _con!.value.position.inSeconds + 2));
}

seek_minus(_con) {
  return _con!.seekTo(Duration(seconds: _con!.value.position.inSeconds - 2));
}

