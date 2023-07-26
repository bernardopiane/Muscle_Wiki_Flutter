import 'package:flutter/material.dart';

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
  final Regime regime = Regime();

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
                body: Center(
                  child: Text(_tabController.index.toString()),
                ),
              ),
            ),
          );
        },
      ),
      body: TabBarView(
        controller: _tabController,
        children: daysOfWeek.map((day) {
          if (regime.exerciseSchedule![day]!.isEmpty) {
            return const Center(
              child: Text("Nothing Scheduled"),
            );
          }
          return ListView.builder(
            itemCount: regime.exerciseSchedule![day]!.length,
            itemBuilder: (context, index) {
              Exercise exercise = regime.exerciseSchedule![day]![index];
              return ListTile(
                title: Text(exercise.exerciseName.toString()),
                // Add other details of the exercise here if needed
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
