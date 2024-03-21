import 'package:flutter/material.dart';

class MoodPicker extends StatefulWidget {
  final String word;
  final Function(int valuePicked) valuePicked;

  MoodPicker({super.key, required this.word, required this.valuePicked});

  @override
  State<MoodPicker> createState() => _MoodPickerState();
}

class _MoodPickerState extends State<MoodPicker> {
  int picked = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.word, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.sentiment_very_dissatisfied, size: 30),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      picked = 1;
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white, // Base color for pastille
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      // Add red dot on selection
                      picked == 1
                          ? Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red, // Red dot color
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    setState(() {
                      picked = 2;
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      picked == 2
                          ? Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    setState(() {
                      picked = 3;
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      picked == 3
                          ? Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
            const Icon(Icons.sentiment_very_satisfied, size: 30),
          ],
        ),
      ],
    );
  }
}
