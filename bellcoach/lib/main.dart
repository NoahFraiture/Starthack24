import 'package:bellcoach/page/people_page.dart';
import 'package:bellcoach/page/sport_page.dart';
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
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  final int idPage = 0;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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
      body: Container(),
      bottomNavigationBar: BottomBarCustom(
        index: 0,
        onTap: (int value) {
          if (value != widget.idPage) {
            Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => const PlaceHolder(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero));
          }
        },
      ),
    );
  }
}
