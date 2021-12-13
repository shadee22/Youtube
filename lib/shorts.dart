// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';

// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:spring/spring.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:video_player/video_player.dart';

class Shorts extends StatefulWidget {
  const Shorts({Key? key}) : super(key: key);

  @override
  _ShortsState createState() => _ShortsState();
}

class _ShortsState extends State<Shorts> {
  VideoPlayerController? _controller;
  VideoPlayerController? _secondVideo;

  bool liked = false;
  bool lComment = false;
  bool playing = false;

  final r = Random(3);

  SpringController like = SpringController(initialAnim: Motion.play);
  SpringController soundBars = SpringController(initialAnim: Motion.loop);

  List<String> videos = ['assets/10.mp4', 'assets/11.mp4'];

  // int videoId = 1;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/10.mp4')..initialize();

    _secondVideo = VideoPlayerController.asset('assets/11.mp4')..initialize();
  }

  @override
  Widget build(BuildContext context) {
    if (liked == true) {
      Timer(Duration(milliseconds: 2000), () {
        setState(() {
          liked = false;
        });
      });
    }

    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new)),
            toolbarHeight: 30,
            title: Text(
              "@SL_PROGRAMMER",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,),
        body: TikTokStyleFullPageScroller(
          contentSize: 6,
          swipePositionThreshold: 0.1,
          swipeVelocityThreshold: 2000,
          onScrollEvent: (ScrollEventType type, {int? currentIndex}) {
            var i = currentIndex;

            i == 0 ? _secondVideo!.play() : null;
          },
          animationDuration: const Duration(milliseconds: 500),
          builder: (BuildContext context, int index) {
            return Stack(
              children: [
                if (index == 0)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _secondVideo!.value.isPlaying
                            ? _secondVideo!.pause()
                            : _secondVideo!.play();
                      });
                    },
                    onDoubleTap: () {
                      setState(() {
                        liked = true;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: _secondVideo!.value.isInitialized
                          ? VideoPlayer(_secondVideo!)
                          : Container(),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                              image: AssetImage('assets/$index.jpg'),
                              fit: BoxFit.cover)),
                    ),
                  ),

                if (index != 0)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller!.value.isPlaying
                            ? _controller!.pause()
                            : _controller!.play();
                      });
                    },
                    onDoubleTap: () {
                      setState(() {
                        liked = true;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: _controller!.value.isInitialized
                          ? VideoPlayer(_controller!)
                          : Container(),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                              image: AssetImage('assets/$index.jpg'),
                              fit: BoxFit.cover)),
                    ),
                  ),

                //Like Buttons
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.circular(30),
                        boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10.0,
                        ),
                      ]),
                      padding: EdgeInsets.all(30),
                      child: ControllerButtons(
                        liked: liked,
                        lComments: lComment,
                      )),
                ),
                //username
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: Container(
                    padding: EdgeInsets.all(30),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              color: Colors.black,
                              image: DecorationImage(
                                  image: AssetImage('assets/3.jpg'),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Username",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Spring.rotate(
                            animDuration: Duration(seconds: 3),
                            springController: soundBars,
                            child: Icon(
                              Icons.library_music_outlined,
                              size: 30,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ),

                //like button
                liked == false
                    ? Container()
                    : Positioned.fill(
                        right: r.nextInt(300).toDouble(),
                        left: r.nextInt(100).toDouble(),
                        top: r.nextInt(500).toDouble(),
                        bottom: r.nextInt(1000).toDouble(),
                        child: Spring.bubbleButton(
                          bubbleStart: 0,
                          bubbleEnd: 4,
                          springController: like,
                          child: Icon(
                            Icons.favorite_rounded,
                            color: Colors.pink,
                            size: 40,
                          ),
                        ),
                      ),
                Positioned(
                  bottom: 90,
                  left: 25,
                  child: Spring.bubbleButton(
                    animDuration: Duration(seconds: 1),
                    child: Icon(
                        _controller!.value.isPlaying ||
                                _secondVideo!.value.isPlaying
                            ? Icons.play_circle_fill
                            : Icons.pause_circle_filled,
                        size: 50,
                        color: Colors.black.withOpacity(0.5)),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

List<IconData> iList = [
  Icons.more_horiz,
  Icons.favorite_outline,
  Icons.delete_forever_outlined,
  Icons.comment_outlined,
  Icons.share_outlined,
];

class ControllerButtons extends StatefulWidget {
  bool? liked;
  bool? lComments;

  ControllerButtons({required this.lComments, required this.liked});

  @override
  _ControllerButtonsState createState() => _ControllerButtonsState();
}

class _ControllerButtonsState extends State<ControllerButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < iList.length; i++)
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 15),
            child: IconButton(
              onPressed: () {
                switch (i) {
                  //3 dots
                  case 0:
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.report_outlined,
                                    size: 35,
                                    color: Colors.red,
                                  ),
                                  title: Text("Report About User"),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.feedback_outlined,
                                    size: 35,
                                    color: Colors.orangeAccent,
                                  ),
                                  title: Text("Feedback"),
                                ),
                              ],
                            ),
                          );
                        });

                    break;
                  //favourite
                  case 1:
                    setState(() {
                      widget.liked = !widget.liked!;
                    });
                    break;
                  case 3:
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  TextField(
                                    onSubmitted: (a) {
                                      setState(() {
                                        listedComments.add(a);
                                      });
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.send_and_archive_outlined,
                                            size: 30,
                                          )),
                                      hintText: "Write Your Comment",
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView(
                                      reverse: true,
                                      children: [
                                        for (var comment in listedComments)
                                          Column(
                                            children: [
                                              Divider(),
                                              ListTile(
                                                title: Text(comment),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (widget.lComments !=
                                                          null) {
                                                        widget.lComments =
                                                            !widget.lComments!;
                                                      }
                                                    });
                                                    print(widget.lComments);
                                                  },
                                                  icon: Icon(
                                                    widget.lComments!
                                                        ? Icons.favorite
                                                        : Icons
                                                            .favorite_outline_rounded,
                                                    color: widget.lComments!
                                                        ? Colors.red
                                                        : Colors.black,
                                                  ),
                                                ),
                                                leading: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                        });
                    break;
                }
              },
              icon: Icon(
                i == 1 && widget.liked! ? Icons.favorite_rounded : iList[i],
                size: 40,
                color: i == 1 && widget.liked! ? Colors.red : Colors.white,
              ),
            ),
          )
      ],
    );
  }

  List<String> listedComments = [
    "first comment",
    "Seconds kasjdfl sad comment",
    "first jkalsd hsdfjsjhgdf sbgfjhsgdfjhsjh",
    "sjhadgfasjhdf sdfhgjsvedwyetd wh comment",
    "sgf dghsf fgs comment",
    "sgf dghsf fgs cdsfasdfomment",
    "sgf dghsf fgs comment",
    "sgf dvcnvbvnghsf fgaddsfs comment",
    "sgf bnvdghsf fgs comment",
    "sgf dghsf fgs comment",
    "sgf dghsf fgs bnvnvvcomment",
    "sgf dghsf fgs comment",
  ];
}
