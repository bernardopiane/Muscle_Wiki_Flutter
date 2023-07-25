import 'package:flutter/material.dart';
import 'package:muscle_project/models/exercise.dart';

class ExercisePage extends StatelessWidget {
  final Exercise exercise;
  const ExercisePage({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.exerciseName.toString()),
      ),
      body: Column(
        children: [
          Text(exercise.exerciseName.toString()),
          Text(exercise.category.toString()),
          Text(exercise.difficulty.toString()),
          Text(exercise.force.toString()),
          Text(exercise.grips.toString()),
          Text("Target : ${exercise.target!.primary.toString()}"),
          Text(exercise.details.toString()),
        ],
      ),
    );
  }
}
