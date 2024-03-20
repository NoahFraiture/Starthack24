import 'package:bellcoach/bottom_bar_custom.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  final int idPage = 1;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text("profile"),
      bottomNavigationBar: BottomBarCustom(
        index: 1,
        onTap: (index) {
          if (index != widget.idPage) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
