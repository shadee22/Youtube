// ignore_for_file: prefer_const_constructors
import 'dart:math';
import 'package:flutter/material.dart';

class Subs extends StatefulWidget {
  const Subs({Key? key}) : super(key: key);

  @override
  _SubsState createState() => _SubsState();
}

class _SubsState extends State<Subs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Icon(Icons.notification_add),
          SizedBox(
            width: 30,
          ),
        ],
        title: Text("Subscriptions",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // ignore_for_file: prefer_const_literals_to_create_immutables
            colors: [
              Colors.black,
              // Colors.blueGrey,
              Colors.orangeAccent,
              Colors.pinkAccent
            ],
          ),
        ),
        padding: EdgeInsets.all(15),
        child: ListWheelScrollView(itemExtent: 200, children: [
          for (var i = 0; i < 10; i++)
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Container(
                    height: double.infinity,
                    width: 50,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0)),
                  ),
                  Container(
                    height: 100,
                    width: 200,
                    child: Text(
                      "Shadeer Wants to Join  Your Channel ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  SizedBox.square(
                    dimension: 40,
                  ),
                  Text(
                    "# $i",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
        ]),
      ),
    );
  }
}
