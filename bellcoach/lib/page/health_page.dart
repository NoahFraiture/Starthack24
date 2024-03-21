import 'package:bellcoach/page/breathing.dart';
import 'package:bellcoach/user.dart';
import 'package:bellcoach/widget/bottom_bar_custom.dart';
import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPage();
}

class _HealthPage extends State<HealthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
            const SizedBox(height: 50),
            const Text("Water drinking", style: TextStyle(fontSize: 20)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              for (int i = 0; i < 6; i++)
                Glass(
                    index: i,
                    iconColor: i <= UserCustom.water
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.onBackground,
                    onTap: (index) => setState(() {
                          if (index == UserCustom.water) {
                            UserCustom.water = index - 1;
                          } else {
                            UserCustom.water = index;
                          }
                        }))
            ]),
            const SizedBox(height: 50),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) => const BreathingPage(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: Icon(
                        Icons.self_improvement,
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
                )
              ],
            )
          ],
        ),
      ),
      appBar: const TopBarCustom(),
      bottomNavigationBar: const BottomBarCustom(pageID: PageID.health),
    );
  }
}

class Glass extends StatelessWidget {
  final int index;
  final Color iconColor;
  final void Function(int index) onTap;
  const Glass({super.key, required this.index, required this.onTap, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => onTap(index), icon: Icon(Icons.water_drop, color: iconColor));
  }
}
