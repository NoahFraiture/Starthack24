import 'package:bellcoach/placeholder.dart';
import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:bellcoach/user.dart';
import 'package:flutter/material.dart';
import 'package:bellcoach/widget/bottom_bar_custom.dart';
import 'package:bellcoach/ressources/colors.dart';
import 'dart:math' show Random;
import 'dart:developer' show log;

import 'package:pedometer/pedometer.dart';
import 'package:flutter_activity_recognition/flutter_activity_recognition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // TODO : change with poll at the beginning of the day
    List<ActivityData> data = [];
    for (int i = 0; i < 7 * 8; i++) {
      data.add(ActivityData(DateTime.now(), Random().nextInt(20)));
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      home: const MyHomePage(), //Replace this with NotificationsPage
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  final int idPage = -1;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class DiscussionPainter extends CustomPainter {
  final Color color;
  DiscussionPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = color;

    var rect = Rect.fromLTWH(0, 0, size.width - 10, size.height);
    var rrect = RRect.fromRectAndRadius(rect, const Radius.circular(15));

    canvas.drawRRect(rrect, paint);

    var path = Path()
      ..addPolygon([
        Offset(size.width - 10, size.height * 0.2),
        Offset(size.width, size.height * 0.3),
        Offset(size.width - 10, size.height * 0.4),
      ], true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(DiscussionPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  // activity init
  final activityRecognition = FlutterActivityRecognition.instance;

  Future<bool> isPermissionGrants() async {
    PermissionRequestResult reqResult;
    reqResult = await activityRecognition.checkPermission();
    if (reqResult == PermissionRequestResult.PERMANENTLY_DENIED) {
      log('Permission is permanently denied.');
      return false;
    } else if (reqResult == PermissionRequestResult.DENIED) {
      reqResult = await activityRecognition.requestPermission();
      if (reqResult != PermissionRequestResult.GRANTED) {
        log('Permission is denied.');
        return false;
      }
    }
    return true;
  }

  // Steps init
  final Stream<StepCount> _stepCountStream = Pedometer.stepCountStream;
  final Stream<PedestrianStatus> _pedestrianStatusStream = Pedometer.pedestrianStatusStream;

  Padding buildWelcomeBubble() {
    var welcome = Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: CustomPaint(
              painter: DiscussionPainter(secondaryColor),
              child: const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text('Welcome Noah !', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
            ),
          ),
          Transform.translate(
            // Adding the Transform.translate widget here
            offset: const Offset(0, 10), // Moving the image 10 pixels down
            child: Image.asset(
              'assets/duolingo.png',
              height: 115,
              width: 115,
            ),
          )
        ],
      ),
    );
    return welcome;
  }

  @override
  Widget build(BuildContext context) {
    // activity recognition for sleep
    isPermissionGrants().then((value) {
      if (!value) {
        log("Permission denied");
        return;
      }
      activityRecognition.activityStream.handleError((e) => log("error")).listen((e) {
        log(e.type.toString());
        if (DateTime.now().difference(UserCustom.lastActivity) > const Duration(hours: 4) &&
            (UserCustom.lastActivity.hour > 22 ||
                UserCustom.lastActivity.hour < 6 ||
                DateTime.now().hour < 6)) {
          UserCustom.addSleep(
              Sleep(DateTime.now(), DateTime.now().difference(UserCustom.lastActivity)));
          UserCustom.lastActivity = DateTime.now();
        } else {
          UserCustom.lastActivity = DateTime.now();
        }
      });
    });

    // Steps counter
    _stepCountStream.listen((value) => UserCustom.currentSteps = value.steps);
    _pedestrianStatusStream.listen((value) {
      if (UserCustom.lastDayWalked.day != DateTime.now().day) {
        UserCustom.lastDayWalked = DateTime.now();
        UserCustom.addWalk(Walk(UserCustom.lastDayWalked, UserCustom.currentSteps));
        UserCustom.currentSteps = 0;
      }
    });

    return Scaffold(
      appBar: const TopBarCustom(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildWelcomeBubble(),
            const SizedBox(height: 90),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: Column(
                children: <Widget>[
                  LinearProgressIndicator(
                    value: 0.7, // 70% progress
                    backgroundColor: backgroundColor,
                    color: secondaryColor,
                    minHeight: 14,
                  ),
                  SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: 0.3, // 30% progress
                    backgroundColor: backgroundColor,
                    color: secondaryColor,
                    minHeight: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBarCustom(pageID: PageID.home),
    );
  }
}
