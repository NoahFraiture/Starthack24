import 'package:bellcoach/page/notifications.dart';
import 'package:bellcoach/widget/grid_widget.dart';
import 'package:bellcoach/page/people_page.dart';
import 'package:bellcoach/placeholder.dart';
import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:bellcoach/user.dart';
import 'package:flutter/material.dart';
import 'package:bellcoach/widget/bottom_bar_custom.dart';
import 'package:bellcoach/ressources/colors.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      home: MyHomePage(), //Replace this with NotificationsPage
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
    var rrect = RRect.fromRectAndRadius(rect, Radius.circular(15));

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
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  'Welcome Noah !',
                  style: TextStyle(color: Colors.white, fontSize: 24)
                ),
              ),
            ),
          ),
          Transform.translate( // Adding the Transform.translate widget here
            offset: Offset(0, 10), // Moving the image 10 pixels down
            child: Image.asset('assets/duolingo.png', height: 115, width: 115,),
          )
        ],
      ),
    );
    return welcome;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarCustom(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildWelcomeBubble(),
            SizedBox(height: 90),
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