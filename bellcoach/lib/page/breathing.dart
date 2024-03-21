import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:flutter/material.dart';

class BreathingPage extends StatefulWidget {
  const BreathingPage({super.key});

  @override
  _BreathingPageState createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const TopBarCustom(showBackButton: true),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          double verticalAlignment = 0;

          if (_animationController.value <= 0.4) {
            verticalAlignment = 1 - (_animationController.value / 0.4);
          } else if (_animationController.value > 0.4 && _animationController.value <= 0.6) {
            verticalAlignment = 0;
          } else if (_animationController.value > 0.6) {
            verticalAlignment = (_animationController.value - 0.6) / 0.4;
          }

          verticalAlignment = (verticalAlignment * 2) - 1;
          verticalAlignment = verticalAlignment * screenHeight * 0.15;

          return Stack(
            children: <Widget>[
              Align(
                alignment: const Alignment(0, 0),
                child: Container(
                  height: screenHeight * 0.48,
                  width: 55.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27.5),
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, verticalAlignment / (screenHeight * 0.3)),
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
