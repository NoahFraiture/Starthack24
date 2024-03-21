import 'package:bellcoach/ressources/colors.dart';
import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:bellcoach/user.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarCustom(),
      body: UserCustom.connected ? loggedIn() : loggedOut(),
    );
  }

  Center loggedOut() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/duolingo.png'),
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  UserCustom.connected = true;
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Login',style: TextStyle(color: primaryFgColor)),
            ),
          ],
        ),
      ),
    );
  }

  Center loggedIn() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/duolingo.png'),
            ),
            const SizedBox(height: 10.0),
            Text("Hello ${UserCustom.name}"),
            Text(UserCustom.email),
            Text("You work at ${UserCustom.placeToString(UserCustom.place)}"),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final TextEditingController nameController = TextEditingController();

                      return AlertDialog(
                          title: const Text('Change name',style: TextStyle(color: primaryFgColor)),
                          content: TextField(
                            controller: nameController,
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel',style: TextStyle(color: primaryFgColor))),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  UserCustom.name = nameController.text;
                                });
                                Navigator.pop(context);
                              },
                              child: const Text('Save',style: TextStyle(color: primaryFgColor)),
                            )
                          ]);
                    });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Set name',style: TextStyle(color: primaryFgColor)),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Change place',style: TextStyle(color: primaryFgColor)),
                        content: DropdownMenu(
                          initialSelection: UserCustom.place,
                          onSelected: (value) {
                            setState(() {
                              UserCustom.place = value!;
                            });
                          },
                          dropdownMenuEntries: [
                            for (Place place in Place.values)
                              DropdownMenuEntry(
                                value: place,
                                label: UserCustom.placeToString(place),
                              )
                          ],
                        ),
                      );
                    });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Work place',style: TextStyle(color: primaryFgColor)),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final TextEditingController emailController = TextEditingController();

                      return AlertDialog(
                          title: const Text('Change email',style: TextStyle(color: primaryFgColor)),
                          content: TextField(
                            controller: emailController,
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel',style: TextStyle(color: primaryFgColor))),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  UserCustom.email = emailController.text;
                                });
                                Navigator.pop(context);
                              },
                              child: const Text('Save',style: TextStyle(color: primaryFgColor)),
                            )
                          ]);
                    });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Change email',style: TextStyle(color: primaryFgColor)),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  UserCustom.connected = false;
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Logout',style: TextStyle(color: primaryFgColor)),
            ),
          ],
        ),
      ),
    );
  }
}
