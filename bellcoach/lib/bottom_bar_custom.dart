import 'package:flutter/material.dart';

class BottomBarCustom extends StatefulWidget {
  final int index;
  final void Function(int) onTap;
  const BottomBarCustom({super.key, required this.index, required this.onTap});

  @override
  State<BottomBarCustom> createState() => _BottomBarCustomState();
}

class _BottomBarCustomState extends State<BottomBarCustom> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.index,
      onTap: widget.onTap,
      items: const [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.bookmark),
          icon: Icon(Icons.bookmark_border),
          label: "Bookmark",
        ),
      ],
    );
  }
}
