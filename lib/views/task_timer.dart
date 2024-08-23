import 'dart:async';
import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskTimer extends StatefulWidget {
  final Task task;
  final Function(Duration) onTimeTracked;

  TaskTimer({required this.task, required this.onTimeTracked});

  @override
  _TaskTimerState createState() => _TaskTimerState();
}

class _TaskTimerState extends State<TaskTimer> {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void _startTimer() {
    setState(() {
      _stopwatch.start();
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  void _stopTimer() {
    _stopwatch.stop();
    _timer?.cancel();
    widget.onTimeTracked(_stopwatch.elapsed);
    setState(() {});
  }

  void _resetTimer() {
    _stopwatch.reset();
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeElapsed = _stopwatch.elapsed;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${timeElapsed.inHours.toString().padLeft(2, '0')}:${(timeElapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(timeElapsed.inSeconds % 60).toString().padLeft(2, '0')}'),
        Row(
          children: [
            IconButton(
              icon: Icon(_stopwatch.isRunning ? Icons.pause : Icons.play_arrow),
              onPressed: _stopwatch.isRunning ? _stopTimer : _startTimer,
            ),
            IconButton(
              icon: Icon(Icons.stop),
              onPressed: _resetTimer,
            ),
          ],
        ),
      ],
    );
  }
}
