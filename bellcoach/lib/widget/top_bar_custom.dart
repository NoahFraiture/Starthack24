import 'package:bellcoach/page/notifications.dart';
import 'package:bellcoach/page/profile_page.dart';
import 'package:bellcoach/user.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../page/shop_page.dart';

class TopBarCustom extends StatefulWidget implements PreferredSizeWidget {
  final bool showBackButton;
  const TopBarCustom({super.key, required this.showBackButton});

  @override
  State<TopBarCustom> createState() => _TopBarCustom();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopBarCustom extends State<TopBarCustom> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.showBackButton,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => const ProfilePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero));
            },
          ),
          const Spacer(),
          InkWell(
              child: Row(children: [
                Text(
                  UserCustom.credits.toString(),
                ),
                const Icon(Icons.diamond_outlined),
              ]),
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => const ShopPage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ));
              }),
          IconButton(
            icon: const Icon(Icons.notifications), // Profile icon
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => NotificationsPage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero));
            },
          )
        ],
      ),
    );
  }
}
