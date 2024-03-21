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
      home: NotificationsPage(), //Replace this with NotificationsPage
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  final int idPage = 0;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
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
