import 'package:bellcoach/bottom_bar_custom.dart';
import 'package:flutter/material.dart';

class PlaceHolder extends StatefulWidget {
  const PlaceHolder({super.key});

  final int idPage = 1;

  @override
  State<PlaceHolder> createState() => _PlaceHolderState();
}

class _PlaceHolderState extends State<PlaceHolder> {
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
