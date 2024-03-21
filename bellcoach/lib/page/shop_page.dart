import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:bellcoach/user.dart';
import 'package:flutter/material.dart';

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
                    for (Item item in Shop.items)
                      if (item.check(UserCustom.self.coachLvl))
                        InkWell(
                          child: sellInfo(item),
                          onTap: () => setState(() => item.action()),
                        )
                  ],
                ),
              ),
              Center(child: Image.asset(UserCustom.coach(), height: 206, width: 206)),
            ],
          ),
        ),
      ),
      appBar: const TopBarCustom(showBackButton: true),
    );
  }
}

Widget sellInfo(Item item) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundImage: AssetImage(item.picturePath),
        ),
        const SizedBox(width: 10.0),
        Text(item.name),
        const Spacer(),
        const SizedBox(width: 10.0),
        Row(
          children: [Text("Price : ${item.credits}"), const Icon(Icons.diamond_outlined)],
        ),
      ],
    ),
  );
}

class Item {
  String picturePath;
  String name;
  int credits;
  void Function() action;
  bool Function(int) check;

  Item(this.picturePath, this.name, this.credits, this.check, this.action);
}

class Shop {
  static int toBuy = 0;
  static List<Item> items = [
    Item("assets/duolingo.png", "Credit Boost", 50, (int a) {
      return true;
    }, () {}),
    Item("assets/duolingo.png", "Special Badge", 300, (int b) {
      return true;
    }, () {}),
    Item("assets/bellgroup.png", "Change Coach Gender", 100, (int a) {
      return true;
    }, () {
      if (UserCustom.self.coachGender == Gender.boy) {
        UserCustom.self.coachGender = Gender.girl;
      } else {
        {
          UserCustom.self.coachGender = Gender.boy;
        }
      }
    }),
    Item("assets/bellgroup.png", "Level up (1 to 2)", 200, (int a) {
      if (a == 1) {
        return true;
      }
      return false;
    }, () {
      UserCustom.self.coachLvl += 1;
    }),
    Item("assets/bellgroup.png", "Level up (2 to 3)", 400, (int a) {
      if (a == 2) {
        return true;
      }
      return false;
    }, () {
      UserCustom.self.coachLvl += 1;
    })
  ];
  static Set<int> bought = {};

  Shop();

  static void buy() {
    Item item = items[toBuy];
    bool test = item.check(UserCustom.self.coachLvl);
    if (test) {
      UserCustom.credits -= item.credits; // If action was executed, substract credits
      UserCustom.self.credits -= item.credits; // If action was executed, substract credits
    }
  }
}
