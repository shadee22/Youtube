// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spring/spring.dart';
import 'package:youtube/player.dart';
import 'package:youtube/shorts.dart';
import 'package:youtube/subs.dart';
// import 'package:youtube/video.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SpringController s0 = SpringController(initialAnim: Motion.play);

  final p5 = EdgeInsets.all(5);

  final white = Colors.white;
  final grey = Colors.black.withOpacity(0.9);
  final lightGrey = Colors.grey.withOpacity(0.5);
  final red = Colors.redAccent;
  final blue = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/u.png'),
            ),
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, color: lightGrey),
                borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.black.withOpacity(0.6),
            actions: [
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.cast_connected_outlined)),
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Subs()));
                  },
                  icon: Icon(Icons.notifications_none_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
              Container(
                margin: p5,
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/5.jpg'), fit: BoxFit.cover),
                ),
              )
            ],
            pinned: false,
            floating: true,
            expandedHeight: 30.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "YouTube",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                //Stories
                if (index == 2) {
                  return Spring.fadeIn(
                    springController: s0,
                    child: Column(
                      children: [
                        Text(
                          "Stories",
                          style: TextStyle(
                              color: white.withOpacity(0.7),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Shorts()));
                          },
                          child: Container(
                            margin: p5,
                            height: 150,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                shrinkWrap: true,
                                reverse: true,
                                itemBuilder: (context, i) {
                                  return Stack(
                                    children: [
                                      Container(
                                        margin: p5,
                                        height: 150,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: i.isOdd ? red : blue,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 0.5,
                                                color: Colors.white),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:
                                                  AssetImage('assets/$i.jpg'),
                                            )),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 0, 0),
                                          height: 40,
                                          width: 150,
                                          child: Text(
                                            storyName[i],
                                            style: TextStyle(
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.black,
                                                Colors.black.withOpacity(0.5),
                                                Colors.transparent
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Player(hero: '${index}_tag')));
                  },
                  child: Spring.slide(
                    slideType: SlideType.slide_in_right,
                    springController: s0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Divider(),
                        Hero(
                          tag: '${index}_tag',
                          child: Container(
                            margin: p5,
                            height: 200,
                            width: 400,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/${index}.jpg')),
                                borderRadius: BorderRadius.circular(10),
                                color: grey),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [Colors.black, Colors.transparent])),
                          margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 23,
                              backgroundColor: white,
                              backgroundImage:
                                  AssetImage('assets/${index + 2}.jpg'),
                            ),
                            subtitle: Text(
                              "${index + 2 * 165} views",
                              style: TextStyle(color: Colors.grey),
                            ),
                            title: Text(
                              "This is The Best Video You ever seen | HappyTone | # ${index * 47} ",
                              style: TextStyle(color: white),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        color: Colors.black,
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              onTap: () {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "added To watch Later ");
                                              },
                                              title: Text(
                                                "Add to Watch Later",
                                                style: TextStyle(
                                                    color: white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              leading: Icon(
                                                Icons.watch_later_outlined,
                                                color: Colors.greenAccent,
                                              ),
                                            ),
                                            ListTile(
                                              onTap: () {
                                                Fluttertoast.showToast(
                                                    msg: "Removing it");
                                              },
                                              title: Text(
                                                "Do not suggest",
                                                style: TextStyle(
                                                    color: white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              leading: Icon(
                                                Icons.not_interested_outlined,
                                                color: red,
                                              ),
                                            ),
                                            ListTile(
                                              onTap: () {
                                                Fluttertoast.showToast(
                                                    msg: "Downlading");
                                              },
                                              title: Text(
                                                "Download",
                                                style: TextStyle(
                                                    color: white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              leading: Icon(
                                                Icons.download_for_offline_outlined,
                                                color: Colors.orangeAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Icon(
                                Icons.exit_to_app,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}

var storyName = [
  'Cat Funny',
  'Avengers Man',
  'Can Maker',
  'Ballondor Messi',
  'This will Blow !',
];
