import 'package:muscle_project/models/exercise.dart';

class Regime {
  Map<String, List<Exercise>>? exerciseSchedule;

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
}
