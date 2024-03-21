import 'package:bellcoach/page/timer_page.dart';
import 'package:bellcoach/widget/bottom_bar_custom.dart';
import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:bellcoach/user.dart';

class SportPage extends StatefulWidget {
  const SportPage({super.key});

  @override
  State<SportPage> createState() => _SportPage();
}

class _SportPage extends State<SportPage> {
  final List<Exercice> exercices = const [
    Exercice(
        picturePath: "assets/t.png",
        duration: Duration(seconds: 30),
        category: SportCategory.muscle,
        name: "T-pose"),
    Exercice(
        picturePath: "assets/pompe.png",
        duration: Duration(seconds: 90),
        category: SportCategory.cardio,
        name: "Push-up"),
    Exercice(
        picturePath: "assets/triangle.png",
        duration: Duration(seconds: 20),
        category: SportCategory.cardio,
        name: "Triangle"),
    Exercice(
        picturePath: "assets/x.png",
        duration: Duration(seconds: 30),
        category: SportCategory.cardio,
        name: "X-pose"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarCustom(),
      body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Change your objective'),
                              content: DropdownMenu(
                                initialSelection: UserCustom.sportCategory,
                                onSelected: (value) {
                                  setState(() {
                                    UserCustom.sportCategory = value!;
                                  });
                                },
                                dropdownMenuEntries: [
                                  for (SportCategory sportCategory in SportCategory.values)
                                    DropdownMenuEntry(
                                      value: sportCategory,
                                      label: UserCustom.sportCategoryToString(sportCategory),
                                    )
                                ],
                              ),
                            );
                          });
                    },
                    icon: const Icon(Icons.ads_click),
                    iconSize: 100,
                  ),
                  const Text("Objetifs", style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            const SizedBox(height: 80),
            const Text("Exercices", style: TextStyle(fontSize: 20)),
            Expanded(
              child: GridView.count(crossAxisCount: 2, children: [
                for (Exercice exercice in exercices)
                  if (exercice.category == UserCustom.sportCategory)
                    Container(
                        margin: const EdgeInsets.all(5),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (context, animation1, animation2) =>
                                      TimerPage(exercice: exercice),
                                  transitionDuration: Duration.zero)),
                          child: Stack(children: [
                            Container(
                                decoration: BoxDecoration(
                                    image:
                                        DecorationImage(image: AssetImage(exercice.picturePath)))),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    width: double.infinity,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                                    )))),
                            Positioned(
                                bottom: 10.0,
                                left: 10.0,
                                child: Text(
                                  exercice.name,
                                  style: const TextStyle(color: Colors.white),
                                ))
                          ]),
                        ))
              ]),
            ),
          ])),
      bottomNavigationBar: const BottomBarCustom(pageID: PageID.running),
    );
  }
}
