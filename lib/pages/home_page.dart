import 'package:flutter/material.dart';
import 'package:muscle_project/widgets/workout_viewer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const WorkoutViewer(),
    );
  }
}
