import 'package:flutter/material.dart';
import 'package:muscle_project/globals.dart';
import 'package:muscle_project/models/exercise.dart';
import 'package:muscle_project/widgets/filtered_list_view.dart';

class WorkoutViewer extends StatefulWidget {
  const WorkoutViewer({Key? key, this.parentListener}) : super(key: key);
  final Function? parentListener;

  @override
  WorkoutViewerState createState() => WorkoutViewerState();
}

class WorkoutViewerState extends State<WorkoutViewer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Exercise>>(
      future: fetchAllWorkouts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for data, show a loading indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // If there's an error, show an error message
          return const Center(
            child: Text('Error loading data'),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          // If data is available, display the list of exercises

          return FilteredListView(dataList: snapshot.data!, parentListener: widget.parentListener,);

          // return ListView.builder(
          //   itemCount: snapshot.data!.length,
          //   itemBuilder: (context, index) {
          //     Exercise exercise = snapshot.data![index];
          //     return ExerciseListTile(
          //       exercise: exercise,
          //       parentListener: widget.parentListener,
          //     );
          //   },
          // );
        } else {
          // If there's no data, show a message indicating no exercises found
          return const Center(
            child: Text('No exercises found.'),
          );
        }
      },
    );
  }

  Future<List<Exercise>> fetchAllWorkouts() async {
    final response = await dio.get("${baseUrl}exercises");
    List<Exercise> exercisesList = [];

    response.data.forEach((e) {
      Exercise exercise = Exercise.fromJson(e);
      exercisesList.add(exercise);
    });

    return exercisesList;
  }
}
