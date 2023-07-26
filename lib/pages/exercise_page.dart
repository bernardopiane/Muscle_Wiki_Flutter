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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (exercise.exerciseName != null)
            Text(exercise.exerciseName.toString()),
          if (exercise.category != null) Text(exercise.category.toString()),
          if (exercise.difficulty != null) Text(exercise.difficulty.toString()),
          if (exercise.force != null) Text(exercise.force.toString()),
          if (exercise.grips != null) Text(exercise.grips.toString()),
          if (exercise.target != null && exercise.target!.primary != null)
            Text("Target : ${exercise.target!.primary.toString()}"),
          if (exercise.details != null) Text(exercise.details.toString()),
        ],
      ),
    );
  }
}
