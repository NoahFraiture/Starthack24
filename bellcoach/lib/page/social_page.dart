import 'package:bellcoach/widget/bottom_bar_custom.dart';
import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:bellcoach/user.dart';
import 'package:flutter/material.dart';

import '../page/people_page.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPage();
}

class _SocialPage extends State<SocialPage> {
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
              const SizedBox(height: 20.0),
              const Text(
                "Your friends",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: ListView(
                  children: [
                    for (People friend in UserCustom.people)
                      if (friend.isFriend) friendInfo(friend, context),
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
      bottomNavigationBar: const BottomBarCustom(pageID: PageID.chat),
    );
  }
}

Widget friendInfo(People people, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => PeoplePage(people: people),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero)
        );
      },
      child:  Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage(people.picturePath),
            ),
            const SizedBox(width: 10.0),
            Text(people.name),
            const Spacer(),
            const Column(
              children: [Icon(Icons.card_giftcard), Text("50")],
            ),
            const SizedBox(width: 10.0),
            Column(
              children: [
                Row(
                  children: [Text("Score : ${people.credits}"), const Icon(Icons.diamond_outlined)],
                ),
                Row(
                  children: [
                    const Icon(Icons.add_location),
                    Text(UserCustom.placeToString(people.place))
                  ],
                )
              ],
            ),
          ],
        ),
    )
  );
}

Widget peopleTooltip(People people) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        CircleAvatar(radius: 30.0, backgroundImage: AssetImage(people.picturePath)),
        Text(people.name),
      ],
    ),
  );
}
