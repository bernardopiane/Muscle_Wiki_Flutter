import 'package:muscle_project/models/exercise.dart';

class Workout {
  Exercise? exercise;
  int? series;
  int? reps;
  int? load;
  int? interval;

  Workout(this.exercise, {this.series, this.reps, this.load, this.interval});
}
