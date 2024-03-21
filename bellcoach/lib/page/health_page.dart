import 'dart:math';

import 'package:bellcoach/user.dart';
import 'package:bellcoach/widget/bottom_bar_custom.dart';
import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:flutter/material.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPage();
}

class _HealthPage extends State<HealthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircularProgressIndicator(
                    value: (UserCustom.sleeps.lastOrNull?.duration.inHours ?? 0) / 8,
                    backgroundColor: Theme.of(context).colorScheme.onBackground,
                    color: Theme.of(context).colorScheme.tertiary,
                    strokeWidth: 5,
                  ),
                  const Icon(Icons.cloud, size: 20),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Row(children: [
                    const Icon(Icons.bed),
                    Text(
                        "${(UserCustom.sleeps.lastOrNull?.date.hour ?? 0) - (UserCustom.sleeps.lastOrNull?.duration.inHours ?? 0)}")
                  ]),
                  Row(children: [
                    const Icon(Icons.alarm),
                    Text("${UserCustom.sleeps.lastOrNull?.date.hour ?? 0}")
                  ]),
                ],
              ),
              const SizedBox(width: 10),
              Text("${UserCustom.sleeps.lastOrNull?.duration.inHours ?? 0} Hours"),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircularProgressIndicator(
                    value: UserCustom.currentSteps / 20000,
                    backgroundColor: Theme.of(context).colorScheme.onBackground,
                    color: Theme.of(context).colorScheme.tertiary,
                    strokeWidth: 5,
                  ),
                  const Icon(Icons.directions_walk, size: 20),
                ],
              ),
              const SizedBox(width: 10),
              Text("${UserCustom.currentSteps} steps today"),
            ],
          ),
          const Text("Water drinking", style: TextStyle(fontSize: 20)),
          Container(), // sleep stats
          Container(), // walk stats
          Container(), // water drinking
          Container(), // button to breathing
          Container(), // button to food
        ],
      ),
      appBar: const TopBarCustom(),
      bottomNavigationBar: const BottomBarCustom(pageID: PageID.health),
    );
  }
}
