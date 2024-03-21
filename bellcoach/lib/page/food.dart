import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:flutter/material.dart';

import '../widget/bottom_bar_custom.dart';

class FoodPage extends StatelessWidget {
  final List<String> urls = [
    'assets/tip1.png',
    'assets/tip2.png',
    'assets/tip3.png',
    'assets/tip4.png',
    'assets/tip5.png',
    'assets/tip6.png'
  ];

  FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarCustom(showBackButton: true),
      bottomNavigationBar: const BottomBarCustom(pageID: PageID.food),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Food Tips',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ), ...urls.map((String url) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: Image.asset(url),
              );
            }),
          ]
            ,
        ),
      ),
    );
  }
}