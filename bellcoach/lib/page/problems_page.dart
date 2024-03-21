import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:bellcoach/user.dart';
import 'package:flutter/material.dart';

class Problems extends StatefulWidget {
  const Problems({super.key});

  @override
  State<Problems> createState() => _Problems();
}

class _Problems extends State<Problems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopBarCustom(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(children: [
                  for (People people in UserCustom.people)
                    for (String problem in people.problems) question(people, problem),
                ]),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final TextEditingController problemController = TextEditingController();

                    return AlertDialog(
                        title: const Text('Add problem'),
                        content: TextField(
                          controller: problemController,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  UserCustom.addSelfMessage(problemController.text);
                                });
                                Navigator.pop(context);
                              },
                              child: const Text('Add'))
                        ]);
                  });
            }));
  }

  Container question(People people, String problem) {
    return Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Stack(clipBehavior: Clip.none, children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Wrap(children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(people.name, style: const TextStyle(fontSize: 20)),
                        Text(
                          problem,
                          style: const TextStyle(fontSize: 16),
                        )
                      ])
                    ]))),
            Positioned(
                top: -20,
                left: -20,
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(people.picturePath),
                          fit: BoxFit.cover,
                        )))),
          ]),
        ));
  }
}
