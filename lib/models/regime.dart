import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'exercise.dart';

class Regime extends ChangeNotifier {
  Map<String, List<Exercise>>? exerciseSchedule = HashMap();

  Regime() {
    exerciseSchedule = {
      'Monday': [],
      'Tuesday': [],
      'Wednesday': [],
      'Thursday': [],
      'Friday': [],
      'Saturday': [],
      'Sunday': [],
    };
  }

  // Setter to add an exercise for a specific day of the week
  void addExerciseForDay(String day, Exercise exercise) {
    if (exerciseSchedule!.containsKey(day)) {
      exerciseSchedule![day]!.add(exercise);
      notifyListeners();
      debugPrint("Exercise Added: $day - ${exercise.exerciseName}");
    } else {
      if (kDebugMode) {
        print('Invalid day: $day');
      }
    }
  }

  // Setter to replace all exercises for a specific day of the week
  void setExercisesForDay(String day, List<Exercise> exercises) {
    if (exerciseSchedule!.containsKey(day)) {
      exerciseSchedule![day] = exercises;
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('Invalid day: $day');
      }
    }
  }

  // Function to remove a specific exercise for a given day of the week
  void removeExerciseForDay(String day, Exercise exercise) {
    if (exerciseSchedule!.containsKey(day)) {
      exerciseSchedule![day]!.remove(exercise);
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('Invalid day: $day');
      }
    }
  }
}
