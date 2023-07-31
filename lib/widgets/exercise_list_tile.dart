import 'package:flutter/material.dart';
import 'package:muscle_project/models/exercise.dart';
import 'package:muscle_project/pages/exercise_page.dart';

class ExerciseListTile extends StatelessWidget {
  final Exercise exercise;
  final Function? parentListener;
  const ExerciseListTile(
      {Key? key, required this.exercise, this.parentListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String id =
    //     exercise.youtubeURL!.substring(exercise.youtubeURL!.length - 11);

    return Card(
      child: InkWell(
        onTap: () {
          if (parentListener != null) {
            parentListener!(exercise);
            Navigator.pop(context);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExercisePage(exercise: exercise)),
            );
          }
        },
        child: Column(
          children: [
            // Image.network('https://img.youtube.com/vi/$id/0.jpg', fit: BoxFit.cover),
            Text(exercise.exerciseName.toString()),
            Text(exercise.difficulty.toString()),
          ],
        ),
      ),
    );
  }
}
