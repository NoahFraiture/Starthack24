import 'package:flutter/material.dart';

import '../widget/top_bar_custom.dart';

class ObjectivesBadgesPage extends StatelessWidget {
  const ObjectivesBadgesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarCustom(showBackButton: false),
      body: Column(
        children: [
          ListTile(
            leading: Checkbox(
                value: true, // set true if goal is reached, false if not
                onChanged: (value) {/* handle when the checkbox changes */}),
            title: Text('Objective 1'),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(10, (index) {
                return Center(
                  child: Card(
                    child: Text('Badge $index'),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
