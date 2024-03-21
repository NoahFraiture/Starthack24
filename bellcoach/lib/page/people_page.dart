import 'dart:developer';
import 'package:bellcoach/widget/grid_widget.dart';
import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:bellcoach/user.dart';
import 'package:flutter/material.dart';

class PeoplePage extends StatefulWidget {
  final People people;

  const PeoplePage({required this.people, super.key});

  @override
  State<PeoplePage> createState() => _PeoplePage();
}

class _PeoplePage extends State<PeoplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarCustom(showBackButton: false),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage(widget.people.picturePath),
              ),
              const SizedBox(height: 15.0),
              Text(widget.people.name),
              const SizedBox(height: 8.0),
              Text("Score : ${widget.people.credits}"),
              const SizedBox(height: 8.0),
              Text(UserCustom.placeToString(widget.people.place)),
              const SizedBox(height: 8.0),
              Text(widget.people.email),
              const SizedBox(height: 8.0),
              Text("Language : ${UserCustom.languageToString(widget.people.language)}"),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.people.isFriend = !widget.people.isFriend;
                        });
                      },
                      icon: widget.people.isFriend
                          ? const Icon(Icons.add_box)
                          : const Icon(Icons.check_box),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: IconButton(
                      onPressed: () {
                        log("Send gift to ${widget.people.name}");
                      },
                      icon: const Icon(Icons.card_giftcard),
                    ),
                  )
                ],
              ),
              Expanded(
                  child:
                      Transform.scale(scale: 0.9, child: GridWidget(data: widget.people.activity))),
            ],
          ),
        ),
      ),
    );
  }
}
