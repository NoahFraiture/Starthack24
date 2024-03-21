import 'package:bellcoach/widget/bottom_bar_custom.dart';
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
    return const Scaffold(
      body: Text("profile"),
      bottomNavigationBar: BottomBarCustom(pageID: PageID.invalid),
    );
  }
}
