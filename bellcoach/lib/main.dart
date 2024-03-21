import 'package:bellcoach/placeholder.dart';
import 'package:bellcoach/problems.dart';
import 'package:bellcoach/top_bar_custom.dart';
import 'package:bellcoach/user.dart';
import 'package:flutter/material.dart';
import 'package:bellcoach/bottom_bar_custom.dart';
import 'package:bellcoach/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: colorScheme,
          useMaterial3: true,
        ),
        home: const Problems());
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
