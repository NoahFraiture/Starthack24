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
  final int idPage = 0;

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
    "The only way to achieve the impossible is to believe it is possible. - Charles Kingsleigh",
    "The harder you work for something, the greater you’ll feel when you achieve it.",
    "Don’t stop when you’re tired. Stop when you’re done. - Marilyn Monroe",
    "The only limit to our realization of tomorrow will be our doubts of today. - Franklin D. Roosevelt",
    "Believe you can and you're halfway there. - Theodore Roosevelt",
    "It does not matter how slowly you go as long as you do not stop. - Confucius",
    "Don't watch the clock; do what it does. Keep going. - Sam Levenson",
    "It always seems impossible until it's done. - Nelson Mandela",
    "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle. - Christian D. Larson",
    "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful. - Albert Schweitzer",
    "The future belongs to those who believe in the beauty of their dreams. - Eleanor Roosevelt",
    "Act as if what you do makes a difference. It does. - William James",
    "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got this. - Chantal Sutherland",
    "Your time is limited, don’t waste it living someone else’s life. - Steve Jobs",
    "Optimism is the faith that leads to achievement. Nothing can be done without hope and confidence. - Helen Keller",
    "You are never too old to set another goal or to dream a new dream. - C.S. Lewis",
    "Success is not final, failure is not fatal: It is the courage to continue that counts. - Winston Churchill",
    "You miss 100% of the shots you don’t take. - Wayne Gretzky",
    "The best way to predict the future is to create it. - Peter Drucker",
    "Don't be afraid to give up the good to go for the great. - John D. Rockefeller",
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
            padding: const EdgeInsets.only(left: 16.0),
            child: CustomPaint(
              painter: DiscussionPainter(secondaryColor),
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Text('Welcome ${UserCustom.name} !', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
            ),
          ),
          Transform.translate(
            // Adding the Transform.translate widget here
            offset: const Offset(0, 10), // Moving the image 10 pixels down
            child: Image.asset(
              'assets/Coach2-1.gif',
              height: 115,
              width: 115,
            ),
          )
        ],
      ),
    );
    return welcome;
  }
  ListView displayBadges() {
    List<String> last4Badges = UserCustom.earnedBadges.reversed.toList().take(4).toList();

    return ListView.builder(
      itemCount: last4Badges.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.badge), // replace with your badge icon
          title: Text(last4Badges[index]),
        );
      },
    );
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
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(10),   // Increase this value for more space
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10),  // Increase this value for more space
                  child: Text(
                    getRandomQuote(),
                    style: TextStyle(
                      fontSize: 15,
                      color: accentColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
            displayBadges()
          ],
        ),
      ),
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
