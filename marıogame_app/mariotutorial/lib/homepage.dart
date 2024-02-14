import 'dart:async';
//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mariotutorial/button.dart';
import 'package:mariotutorial/jumpingmario.dart';
import 'package:mariotutorial/mario.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1;
  double time = 0;
  double height = 0;
  double initalHeight = marioY;
  String direction = "right";
  bool midrun = false;
  bool midJump = false;

  void preJump() {
    time = 0;
    initalHeight = marioY;
  }

  void jump() {
    midJump = true;
    preJump();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 5 * time;

      if (initalHeight - height > 1) {
        midJump = false;

        setState(() {
          marioY = 1;
        });
        timer.cancel();
      } else {
        setState(() {
          marioY = initalHeight - height;
        });
      }
    });
  }

  void moveRight() {
    direction = "right";

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (MyButton().userIsHoldingButton() == true) {
        setState(() {
          marioX += 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    direction = "left";

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (MyButton().userIsHoldingButton() == true) {
        setState(() {
          marioX -= 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  color: Colors.blue,
                  child: AnimatedContainer(
                    alignment: Alignment(marioX, marioY),
                    duration: Duration(milliseconds: 0),
                    child: midJump
                        ? JumpingMario(
                            direction: direction,
                          )
                        : MyMario(
                            direction: direction,
                            midrun: midrun,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "MARIO",
                            style: TextStyle(
                                fontFamily: "Press", color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "0000",
                            style: TextStyle(
                                fontFamily: "Press", color: Colors.white),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "WORLD",
                            style: TextStyle(
                                fontFamily: "Press", color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "1-1",
                            style: TextStyle(
                                fontFamily: "Press", color: Colors.white),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "TIME",
                            style: TextStyle(
                                fontFamily: "Press", color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "9999",
                            style: TextStyle(
                                fontFamily: "Press", color: Colors.white),
                          ),
                          SizedBox(height: 10),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    function: moveLeft,
                  ),
                  MyButton(
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                    function: jump,
                  ),
                  MyButton(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    function: moveRight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
