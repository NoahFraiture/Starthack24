import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:bellcoach/user.dart';
import 'package:flutter/material.dart';

import '../page/social_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPage();
}

class _ShopPage extends State<ShopPage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(
                controller: textController,
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Shop",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: ListView(
                  children: [
                    for (People friend in UserCustom.people)
                      if (friend.isFriend) friendInfo(friend),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                "People speaking ${UserCustom.languageToString(UserCustom.language)}",
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: Wrap(
                  children: [
                    for (People people in UserCustom.people)
                      if (people.email != UserCustom.email &&
                          !people.isFriend &&
                          people.place == UserCustom.place &&
                          people.language == UserCustom.language)
                        peopleTooltip(people),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: const TopBarCustom(showBackButton: false),
    );
  }
}
