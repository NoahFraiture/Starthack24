import 'package:bellcoach/page/breathing.dart';
import 'package:bellcoach/page/food.dart';
import 'package:bellcoach/placeholder.dart';
import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:bellcoach/user.dart';
import 'package:flutter/material.dart';
import 'package:bellcoach/widget/bottom_bar_custom.dart';
import 'package:bellcoach/ressources/colors.dart';
import 'dart:math' show Random, min;
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
      home: FoodPage(), //Replace this with NotificationsPage
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
  List<String> quotes = [
    "The only way to achieve the impossible is to believe it is possible.\n- Charles Kingsleigh",
    "The harder you work for something, the greater you’ll feel when you achieve it.",
    "Don’t stop when you’re tired. Stop when you’re done.\n- Marilyn Monroe",
    "The only limit to our realization of tomorrow will be our doubts of today.\n- Franklin D. Roosevelt",
    "Believe you can and you're halfway there.\n- Theodore Roosevelt",
    "It does not matter how slowly you go as long as you do not stop.\n- Confucius",
    "Don't watch the clock; do what it does. Keep going.\n- Sam Levenson",
    "It always seems impossible until it's done.\n- Nelson Mandela",
    "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle.\n- Christian D. Larson",
    "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful.\n- Albert Schweitzer",
    "The future belongs to those who believe in the beauty of their dreams.\n- Eleanor Roosevelt",
    "Act as if what you do makes a difference. It does.\n- William James",
    "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got this.\n- Chantal Sutherland",
    "Your time is limited, don’t waste it living someone else’s life.\n- Steve Jobs",
    "Optimism is the faith that leads to achievement. Nothing can be done without hope and confidence.\n- Helen Keller",
    "You are never too old to set another goal or to dream a new dream.\n- C.S. Lewis",
    "Success is not final, failure is not fatal: It is the courage to continue that counts.\n- Winston Churchill",
    "You miss 100% of the shots you don’t take.\n- Wayne Gretzky",
    "The best way to predict the future is to create it.\n- Peter Drucker",
    "Don't be afraid to give up the good to go for the great.\n- John D. Rockefeller",
  ];

  String getRandomQuote() {
    var random = new Random();
    return quotes[random.nextInt(quotes.length)];
  }

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
            padding: const EdgeInsets.only(left: 7), // try reducing this value
            child: CustomPaint(
              painter: DiscussionPainter(secondaryColor),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Welcome ${UserCustom.name} ! \nYou\'re doing such\na great job !',
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, 0),
            child: Image.asset(
              UserCustom.coach(),
              height: 206,
              width: 206,
            ),
          )
        ],
      ),
    );
    return welcome;
  }

  Widget displayBadges() {
    List<String> last4Badges = UserCustom.earnedBadges.reversed.toList().take(4).toList();
    if (last4Badges.isEmpty) {
      return ListView(
        shrinkWrap: true,
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.sentiment_very_dissatisfied),
            title: Text('No badges earned yet'),
          ),
        ],
      );
    } else {
      return Wrap(
        alignment: WrapAlignment.spaceAround,
        children: last4Badges.map((badgeName) {
          String badgeImage = 'assets/meditation.png';

          if (badgeName == 'Meditation') {
            badgeImage = 'assets/meditation.png';
          } else if (badgeName == 'No Sugar') {
            badgeImage = 'assets/noSugar.png';
          } else if (badgeName == 'Sleep') {
            badgeImage = 'assets/sleep.png';
          } else if (badgeName == 'Walking 21 days') {
            badgeImage = 'assets/Steps21days.png';
          }

          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              badgeImage,
              width: 90,
              fit: BoxFit.cover,
            ),
          );
        }).toList(),
      );
    }
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
        if (DateTime.now().difference(UserCustom.lastAwake) > const Duration(hours: 4) &&
            (UserCustom.lastAwake.hour > 22 ||
                UserCustom.lastAwake.hour < 6 ||
                DateTime.now().hour < 6)) {
          UserCustom.addSleep(
              Sleep(DateTime.now(), DateTime.now().difference(UserCustom.lastAwake)));
          UserCustom.lastAwake = DateTime.now();
        } else {
          UserCustom.lastAwake = DateTime.now();
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
      appBar: const TopBarCustom(showBackButton: false),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildWelcomeBubble(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10), // Increase this value for more space
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10), // Increase this value for more space
                  child: Text(
                    getRandomQuote(),
                    style: const TextStyle(
                      fontSize: 15,
                      color: textColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: displayBadges(), // Your ListView.builder
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/steps.png',
                        height: 45,
                        width: 45,
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 20, // Define the height of the progress bar
                          width: 200,
                          child: LinearProgressIndicator(
                            value: min(UserCustom.currentSteps / 10000, 1),
                            color: secondaryColor,
                            backgroundColor: Colors.grey[300],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text('${UserCustom.currentSteps} / 10000 steps'),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(Icons.water_drop, color: Colors.black, size: 30),
                      const SizedBox(
                        width: 13.0, // More space
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 20,
                          width: 200,
                          child: LinearProgressIndicator(
                            value: min(UserCustom.water / 8,
                                1), // ensuring value is between 0 and 1 with min
                            color: secondaryColor,
                            backgroundColor: Colors.grey[300],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text('${UserCustom.water} / 8 glasses of water'),
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
