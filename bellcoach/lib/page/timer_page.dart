import 'package:bellcoach/user.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class TimerPage extends StatefulWidget {
  final Exercice exercice;

  const TimerPage({super.key, required this.exercice});

  @override
  State<TimerPage> createState() => _TimerPage();
}

class _TimerPage extends State<TimerPage> with TickerProviderStateMixin {
  late int _duration;
  CountdownController countdownController = CountdownController();
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _duration = widget.exercice.duration.inSeconds;
  }

  void _onTimerEnd() {
    UserCustom.addSportData(SportData(widget.exercice, DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercice.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.exercice.picturePath),
            const SizedBox(height: 20.0),
            Countdown(
              seconds: _duration,
              build: (BuildContext context, double time) {
                return Text(
                  time.toInt().toString(),
                  style: const TextStyle(fontSize: 32.0),
                );
              },
              onFinished: _onTimerEnd,
              controller: countdownController,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _isTimerRunning
                  ? () {
                      setState(() {
                        countdownController.pause();
                        _isTimerRunning = false;
                      });
                    }
                  : () {
                      setState(() {
                        countdownController.start();
                        _isTimerRunning = true;
                      });
                    },
              child: Text(
                _isTimerRunning ? 'Stop' : 'Start',
                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
