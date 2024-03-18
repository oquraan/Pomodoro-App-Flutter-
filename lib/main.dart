// ignore_for_file: prefer_const_constructors
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: PomodoroApp(),
    );
  }
}

class PomodoroApp extends StatefulWidget {
  const PomodoroApp({super.key});

  @override
  State<PomodoroApp> createState() => _PomodoroAppState();
}

class _PomodoroAppState extends State<PomodoroApp> {
  Timer? t1;
  Duration duration = Duration(minutes: 25);
  bool isRuning = false;

  startTimer() {
    t1 = Timer.periodic(Duration(microseconds: 1), (timer) {
      setState(() {
        int newSecond = duration.inSeconds - 1;
        //newSecond--;
        duration = Duration(seconds: newSecond);
        if (duration.inMinutes == 0 && duration.inSeconds == 0) {
          setState(() {
            t1!.cancel();
            duration = Duration(minutes: 25);
            isRuning = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Poodoro App",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        backgroundColor: Color.fromARGB(255, 50, 65, 71),
      ),
      backgroundColor: Color.fromARGB(255, 33, 40, 43),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 150.0,
              center: Text(
                "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                style: TextStyle(fontSize: 80, color: Colors.white),
              ),
              progressColor: Color.fromARGB(255, 255, 85, 113),
              backgroundColor: Colors.grey,
              lineWidth: 8.0,
              percent: duration.inMinutes/25,
              animation: true,
              animateFromLastPercent: true,
              animationDuration: 1000,
            )
          ],
        ),SizedBox(height: 20,),
        
        if (!isRuning)
          ElevatedButton(
            onPressed: () {
              isRuning = true;

              !startTimer();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              padding: MaterialStateProperty.all(EdgeInsets.all(12)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
            ),
            child: Text(
              "Start Study ",
              style: TextStyle(fontSize: 19, color: Colors.white),
            ),
          ),
        if (isRuning)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    t1!.cancel();
                    isRuning = false;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 198, 46, 35)),
                  padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
                child: Text(
                  "Stop Timer",
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    t1!.cancel();
                    duration = Duration(minutes: 25);
                    isRuning = false;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 198, 46, 35)),
                  padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
                child: Text(
                  "Cancel Timer",
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
              ),
            ],
          ),
      ]),
    );
  }
}
