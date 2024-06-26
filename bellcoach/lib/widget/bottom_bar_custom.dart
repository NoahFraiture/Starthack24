import 'package:bellcoach/main.dart';
import 'package:bellcoach/page/food.dart';
import 'package:bellcoach/page/problems_page.dart';
import 'package:bellcoach/page/social_page.dart';
import 'package:bellcoach/page/sport_page.dart';
import 'package:bellcoach/page/health_page.dart';
import 'package:flutter/material.dart';

class BottomBarCustom extends StatefulWidget {
  final PageID pageID;
  const BottomBarCustom({super.key, required this.pageID});

  @override
  State<BottomBarCustom> createState() => _BottomBarCustomState();
}

class _BottomBarCustomState extends State<BottomBarCustom> {
  void onTap(int value) {
    if (intoPageID(value) == widget.pageID) {
      return;
    }
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            return switch (intoPageID(value)) {
              PageID.running => const SportPage(),
              PageID.health => const HealthPage(),
              PageID.factory => const Problems(),
              PageID.chat => const SocialPage(),
              PageID.notification => throw UnimplementedError(),
              PageID.food => FoodPage(),
              PageID.invalid => throw UnimplementedError(),
              PageID.home => const MyHomePage(),
              PageID.profile => throw UnimplementedError(),
            };
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: intoInt(widget.pageID),
      onTap: onTap,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_run,
              color: widget.pageID == PageID.running
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.onBackground,
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.health_and_safety,
              color: widget.pageID == PageID.health
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.onBackground,
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: widget.pageID == PageID.home
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.onBackground,
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: widget.pageID == PageID.chat
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.onBackground,
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.factory,
              color: widget.pageID == PageID.factory
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.onBackground,
            ),
            label: ""),
      ],
    );
  }

  PageID intoPageID(int index) {
    switch (index) {
      case 0:
        return PageID.running;
      case 1:
        return PageID.health;
      case 2:
        return PageID.home;
      case 3:
        return PageID.chat;
      case 4:
        return PageID.factory;
      default:
        return PageID.invalid;
    }
  }

  int intoInt(PageID pageID) {
    switch (pageID) {
      case PageID.running:
        return 0;
      case PageID.health:
        return 1;
      case PageID.home:
        return 2;
      case PageID.chat:
        return 3;
      case PageID.factory:
        return 4;
      default:
        return 0;
    }
  }
}

enum PageID { home, profile, running, health, factory, chat, notification, invalid, food }
