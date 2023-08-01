import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'exercise.dart';

class Regime extends ChangeNotifier {
  Map<String, List<Exercise>>? exerciseSchedule = HashMap();

  Regime() {
    _loadExerciseSchedule();
  }

  void _saveExerciseSchedule() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('exerciseSchedule', jsonEncode(exerciseSchedule));
  }

  // Load the exerciseSchedule from SharedPreferences
  void _loadExerciseSchedule() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('exerciseSchedule');
    if (jsonString != null) {
      Map<String, dynamic> decodedData = jsonDecode(jsonString);
      exerciseSchedule = decodedData.map(
        (key, value) {
          // Convert each element of the decoded list to a Map<String, dynamic>
          List<dynamic> exerciseList = value;
          List<Exercise> exercises =
              exerciseList.map((item) => Exercise.fromJson(item)).toList();
          return MapEntry(key, exercises);
        },
      );
    } else {
      // If no data is found in SharedPreferences, use the default data
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
    notifyListeners();
  }

// Setter to add an exercise for a specific day of the week
  void addExerciseForDay(String day, Exercise exercise) {
    try {
      if (exerciseSchedule!.containsKey(day)) {
        // Check if the exercise with the same exerciseName already exists in the list
        if (exerciseSchedule![day]!.any((existingExercise) =>
            existingExercise.exerciseName == exercise.exerciseName)) {
          // Notify the user that the exercise is already added for the selected day
          Fluttertoast.showToast(
              msg:
                  'Exercise "${exercise.exerciseName}" already added for $day');
        } else {
          exerciseSchedule![day]!.add(exercise);
          _saveExerciseSchedule();
          notifyListeners();
        }
      } else {
        throw Exception('Invalid day: $day');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      if (kDebugMode) {
        print('Error adding exercise: $e');
      }
    }
  }

// Setter to replace all exercises for a specific day of the week
  void setExercisesForDay(String day, List<Exercise> exercises) {
    try {
      if (exerciseSchedule!.containsKey(day)) {
        exerciseSchedule![day] = exercises;
        _saveExerciseSchedule();

        notifyListeners();
      } else {
        throw Exception('Invalid day: $day');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      if (kDebugMode) {
        print('Error setting exercises: $e');
      }
    }
  }

// Function to remove a specific exercise for a given day of the week
  void removeExerciseForDay(String day, Exercise exercise) {
    try {
      if (exerciseSchedule!.containsKey(day)) {
        exerciseSchedule![day]!.remove(exercise);
        _saveExerciseSchedule();

        notifyListeners();
      } else {
        throw Exception('Invalid day: $day');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      if (kDebugMode) {
        print('Error removing exercise: $e');
      }
    }
  }
}
