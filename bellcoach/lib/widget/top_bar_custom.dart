import 'package:bellcoach/page/profile_page.dart';
import 'package:bellcoach/user.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class TopBarCustom extends StatefulWidget implements PreferredSizeWidget {
  const TopBarCustom({super.key});

  @override
  State<TopBarCustom> createState() => _TopBarCustom();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopBarCustom extends State<TopBarCustom> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.home), // Profile icon
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => const MyHomePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero));
            },
          ),
          const Spacer(),
          Row(children: [
            Text(
              UserCustom.credits.toString(),
            ),
            const Icon(Icons.diamond_outlined),
          ]),
          IconButton(
            icon: const Icon(Icons.account_circle), // Profile icon
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => const ProfilePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero));
            },
          ),
        ],
      ),
    );
  }
}
