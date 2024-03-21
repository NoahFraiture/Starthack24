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
      appBar: const TopBarCustom(showBackButton: false),
      body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center both vertically and horizontally
                children: [
                  DropdownButtonFormField<SportCategory>(
                    // Use DropdownButtonFormField for better styling
                    value: UserCustom.sportCategory,
                    icon: const Icon(Icons.arrow_drop_down), // More intuitive dropdown icon
                    iconSize: 24, // Adjust icon size as needed
                    items: SportCategory.values.map((sportCategory) {
                      return DropdownMenuItem<SportCategory>(
                        value: sportCategory,
                        child: Text(UserCustom.sportCategoryToString(sportCategory)),
                      );
                    }).toList(),
                    onChanged: (newSportCategory) {
                      setState(() {
                        UserCustom.sportCategory = newSportCategory!;
                      });
                    },
                    decoration: InputDecoration(
                      // Customize dropdown button appearance
                      labelText: 'Objectifs', // Use a clear label for accessibility and guidance
                      filled: true, // Add a subtle fill color
                      fillColor: Colors.grey[200], // Adjust fill color if desired
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0), // Adjust padding
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0), // Rounded corners
                        borderSide: BorderSide(color: Colors.grey[400]!), // Lighter border
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            const Text("Exercices", style: TextStyle(fontSize: 20)),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.6, // Adjust aspect ratio for a more pleasing layout (optional)
                children: [
                  for (Exercice exercice in exercices)
                    if (exercice.category == UserCustom.sportCategory)
                      InkWell(
                        // Use InkWell for a more natural tap feedback
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                TimerPage(exercice: exercice),
                            transitionDuration: Duration.zero,
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(8.0), // Adjust margin for spacing
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0), // Rounded corners
                            boxShadow: [
                              // Add subtle shadow for depth
                              BoxShadow(
                                color: Colors.grey[300]!.withOpacity(0.5),
                                offset: const Offset(2.0, 4.0), // Adjust shadow offset
                                blurRadius: 4.0, // Adjust shadow blur
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage(exercice.picturePath),
                              fit: BoxFit.cover, // Ensure image covers the container
                            ),
                          ),
                          child: Stack(
                            children: [
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
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10.0,
                                left: 10.0,
                                child: Text(
                                  exercice.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0, // Adjust font size
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ])),
      bottomNavigationBar: const BottomBarCustom(pageID: PageID.running),
    );
  }
}
