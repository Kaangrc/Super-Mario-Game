import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double marioX = 0;
  double marioY = 1;
  double initialY = 1;
  double time = 0;
  double gravity = -4.9;
  double velocity = 4.5;
  bool isJumping = false;
  bool gameHasStarted = false;
  bool isGameOver = false;
  double moveSpeed = 0.05;
  int score = 0;

  List<double> barrierX = [2, 3.5, 5];
  List<List<double>> barrierHeight = [
    [0.2, 0.3],
    [0.2, 0.25],
    [0.15, 0.3],
  ];

  double barrierWidth = 0.2;
  Timer? gameTimer;

  void startGame() {
    gameHasStarted = true;
    isGameOver = false;
    score = 0;
    gameTimer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {
        if (isJumping) {
          time += 0.03;
          double height = gravity * time * time + velocity * time;
          marioY = initialY - height;

          if (marioY > 1) {
            marioY = 1;
            isJumping = false;
            time = 0;
          }
        }

        for (int i = 0; i < barrierX.length; i++) {
          barrierX[i] -= 0.02;
          if (barrierX[i] < -1.5) {
            barrierX[i] += 3.5;
            score++;
          }
        }

        checkCollision();
      });
    });
  }

  void checkCollision() {
    for (int i = 0; i < barrierX.length; i++) {
      double marioTop = marioY - 0.05;
      double marioBottom = marioY + 0.05;
      double marioLeft = marioX - 0.05;
      double marioRight = marioX + 0.05;

      double barrierLeft = barrierX[i] - barrierWidth / 2;
      double barrierRight = barrierX[i] + barrierWidth / 2;

      double topBarrierBottom = -1 + barrierHeight[i][0];
      double bottomBarrierTop = 1 - barrierHeight[i][1];

      bool hitsTop = marioTop < topBarrierBottom &&
          marioRight > barrierLeft &&
          marioLeft < barrierRight;
      bool hitsBottom = marioBottom > bottomBarrierTop &&
          marioRight > barrierLeft &&
          marioLeft < barrierRight;

      if (hitsTop || hitsBottom) {
        gameOver();
        break;
      }
    }
  }

  void gameOver() {
    gameTimer?.cancel();
    setState(() {
      isGameOver = true;
      gameHasStarted = false;
    });
  }

  void resetGame() {
    marioX = 0;
    marioY = 1;
    initialY = 1;
    time = 0;
    isJumping = false;
    barrierX = [2, 3.5, 5];
    startGame();
  }

  void jump() {
    if (!gameHasStarted) {
      startGame();
    } else if (!isJumping) {
      isJumping = true;
      initialY = marioY;
      time = 0;
    } else if (isGameOver) {
      resetGame();
    }
  }

  void moveLeft() {
    if (marioX > -1) {
      setState(() {
        marioX -= moveSpeed;
      });
    }
  }

  void moveRight() {
    if (marioX < 1) {
      setState(() {
        marioX += moveSpeed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: jump,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(color: Colors.blue),
                  Align(
                    alignment: Alignment(marioX, marioY),
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.red,
                    ),
                  ),
                  ...List.generate(barrierX.length, (i) {
                    return Stack(
                      children: [
                        Align(
                          alignment: Alignment(barrierX[i], -1),
                          child: Container(
                            width: MediaQuery.of(context).size.width *
                                barrierWidth /
                                2,
                            height: MediaQuery.of(context).size.height *
                                barrierHeight[i][0] /
                                2,
                            color: Colors.green,
                          ),
                        ),
                        Align(
                          alignment: Alignment(barrierX[i], 1),
                          child: Container(
                            width: MediaQuery.of(context).size.width *
                                barrierWidth /
                                2,
                            height: MediaQuery.of(context).size.height *
                                barrierHeight[i][1] /
                                2,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    );
                  }),
                  if (!gameHasStarted && !isGameOver)
                    Center(
                      child: Text(
                        'TAP TO START',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  if (isGameOver)
                    Center(
                      child: Text(
                        'GAME OVER\nSCORE: $score',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    )
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: moveLeft,
                      icon: Icon(Icons.arrow_left, size: 40),
                    ),
                    IconButton(
                      onPressed: jump,
                      icon: Icon(Icons.arrow_upward, size: 40),
                    ),
                    IconButton(
                      onPressed: moveRight,
                      icon: Icon(Icons.arrow_right, size: 40),
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
}
