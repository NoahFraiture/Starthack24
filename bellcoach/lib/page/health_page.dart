import 'package:bellcoach/page/breathing.dart';
import 'package:bellcoach/user.dart';
import 'package:bellcoach/main.dart';
import 'package:bellcoach/widget/bottom_bar_custom.dart';
import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'food.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPage();
}

class _HealthPage extends State<HealthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomPaint(
                    painter: DiscussionPainter(Theme.of(context).colorScheme.secondary),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text('Hey ${UserCustom.name} ! \nDon\'t forget to drink !',
                          style: const TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                  ),
                  Image.asset(
                    UserCustom.coachPath,
                    height: 206,
                    width: 206,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
              ),
              const SizedBox(height: 50),
              const Text("Water drinking", style: TextStyle(fontSize: 20)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                for (int i = 0; i < 4; i++)
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
                          })),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                for (int i = 4; i < 8; i++)
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
                          })),
              ]),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) => FoodPage(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: Icon(
                        Icons.fastfood_rounded,
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
                  ElevatedButton(
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
                ],
              )
            ],
          ),
        ),
      ),
      appBar: const TopBarCustom(showBackButton: false),
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
      onPressed: () => onTap(index),
      icon: Icon(Icons.water_drop, color: iconColor, size: 40),
      padding: EdgeInsets.all(20),
    );
  }
}
