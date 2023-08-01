import 'package:flutter/material.dart';
import 'package:muscle_project/models/exercise.dart';
import 'package:muscle_project/utils.dart';

class ExercisePage extends StatelessWidget {
  final Exercise exercise;
  const ExercisePage({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.exerciseName.toString()),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(8),
        child: ListView(
          children: [
            if (exercise.exerciseName != null)
              Text(exercise.exerciseName.toString()),
            if (exercise.category != null) Text(exercise.category.toString()),
            if (exercise.difficulty != null)
              Text(exercise.difficulty.toString()),
            if (exercise.force != null) Text(exercise.force.toString()),
            if (exercise.grips != null) Text(exercise.grips.toString()),
            _buildTarget(exercise.target!),
            // if (exercise.target != null && exercise.target!.primary != null)
            //   Text("Target : ${exercise.target!.primary.toString()}"),
            if (exercise.details != null) Text(exercise.details.toString()),
          ],
        ),
      ),
    );
  }

  _buildTarget(Target target) {
    List<String> muscleTargets = [];
    if (target.primary != null) {
      if (target.primary!.length > 1) {
        muscleTargets.addAll(exercise.target!.primary!);
      } else {
        muscleTargets.add(removeBrackets(exercise.target!.primary!.toString()));
      }
    }
    if (target.secondary != null) {
      if (target.secondary!.length > 1) {
        muscleTargets.addAll(exercise.target!.secondary!);
      } else {
        muscleTargets.add(removeBrackets(exercise.target!.secondary!.toString()));
      }
    }
    if (target.tertiary != null) {
      if (target.tertiary!.length > 1) {
        muscleTargets.addAll(exercise.target!.tertiary!);
      } else {
        muscleTargets.add(removeBrackets(exercise.target!.tertiary!.toString()));
      }
    }

    if(muscleTargets.isEmpty){
      return const SizedBox.shrink();
    }
    // TODO Build widget with pictures
    return Text("Target : ${muscleTargets.toString()}");
  }
}
