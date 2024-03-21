import 'package:flutter/material.dart';

import '../user.dart';

class GridWidget extends StatelessWidget {
  final List<ActivityData> data;

  const GridWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    data.sort((a, b) => b.date.compareTo(a.date));
    int min = data.map((e) => e.value).reduce((min, value) => min < value ? min : value);
    int max = data.map((e) => e.value).reduce((max, value) => max > value ? max : value);
    return GridView.count(
        crossAxisCount: 7,
        children: data.map((e) => _buildActivityCell(min, e.value, max)).toList());
  }

  Widget _buildActivityCell(int min, int value, int max) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: () {
          double percent = (value - min).toDouble() / (max - min).toDouble();
          value = (percent * 1000).toInt();
          if (value > 900) {
            return Colors.green[900];
          } else if (value > 800) {
            return Colors.green[800];
          } else if (value > 700) {
            return Colors.green[700];
          } else if (value > 600) {
            return Colors.green[600];
          } else if (value > 500) {
            return Colors.green[500];
          } else if (value > 400) {
            return Colors.green[400];
          } else if (value > 300) {
            return Colors.green[300];
          } else if (value > 200) {
            return Colors.green[200];
          } else if (value > 100) {
            return Colors.green[100];
          } else {
            return Colors.green[50];
          }
        }(),
      ),
    );
  }
}
