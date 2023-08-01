import 'package:flutter/material.dart';
import 'package:muscle_project/widgets/workout_viewer.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';
import '../models/regime.dart';

class RegimePage extends StatefulWidget {
  const RegimePage({Key? key}) : super(key: key);

  @override
  State<RegimePage> createState() => _RegimePageState();
}

class _RegimePageState extends State<RegimePage>
    with SingleTickerProviderStateMixin {
  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: daysOfWeek.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabbed Navbar for Days'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: daysOfWeek.map((day) => Tab(text: day)).toList(),
        ),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(title: Text("Add exercise for ${daysOfWeek[_tabController.index]}"),),
                body: Center(
                  child: WorkoutViewer(
                    parentListener: itemClick,
                  ),
                  // child: WorkoutViewer(
                  //   parentListener: itemClick,
                  // ),

                ),
              ),
            ),
          );
        },
      ),
      body: Consumer<Regime>(builder: (context, regime, child) {
        return TabBarView(
          controller: _tabController,
          children: daysOfWeek.map((day) {
            List<Exercise> exercises = regime.exerciseSchedule![day] ?? [];
            return ExerciseList(exercises: exercises);
          }).toList(),
        );
      }),
    );
  }

  itemClick(Exercise e) {
    Provider.of<Regime>(context, listen: false)
        .addExerciseForDay(daysOfWeek.elementAt(_tabController.index), e);
  }
}

class ExerciseList extends StatelessWidget {
  final List<Exercise> exercises;

  const ExerciseList({super.key, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        Exercise exercise = exercises[index];
        return ListTile(
          title: Text(exercise.exerciseName.toString()),
          // Add other details of the exercise here if needed
        );
      },
    );
  }
}
