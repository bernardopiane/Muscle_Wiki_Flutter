import 'package:flutter/material.dart';
import 'package:muscle_project/models/exercise.dart';
import 'package:muscle_project/widgets/exercise_list_tile.dart';

class FilteredListView extends StatefulWidget {
  final List<Exercise> dataList;
  final Function? parentListener;
  const FilteredListView({Key? key, required this.dataList, this.parentListener}) : super(key: key);

  @override
  FilteredListViewState createState() => FilteredListViewState();
}

class FilteredListViewState extends State<FilteredListView> {
  String? category;
  String? difficulty;
  String? target;

  List<String>? categories;
  List<String>? difficulties;
  List<String>? targets;

  List<Exercise> get filteredData {
    // Perform filtering based on selected dropdown values
    List<Exercise> filteredList = widget.dataList;

    if (category != null) {
      filteredList =
          filteredList.where((item) => item.category == category).toList();
    }

    if (difficulty != null) {
      filteredList =
          filteredList.where((item) => item.difficulty == difficulty).toList();
    }

    if (target != null) {
      filteredList = filteredList
          .where((item) =>
              item.target?.primary
                  .toString()
                  .replaceAll("[", "")
                  .replaceAll("]", "") ==
              target)
          // Fixes [Target] coming from API as String
          .toList();
    }

    return filteredList;
  }

  @override
  void initState() {
    super.initState();
    categories = widget.dataList
        .where((exercise) => exercise.category != null)
        .map((exercise) => exercise.category!)
        .toList()
        .toSet()
        .toList();
    // .toSet().toList(); Remove valores duplicados
    difficulties = widget.dataList
        .where((exercise) => exercise.difficulty != null)
        .map((exercise) => exercise.difficulty!)
        .toList()
        .toSet()
        .toList();
    //   TARGETS
    extractTargets(widget.dataList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 16),
            DropdownButton<String>(
              hint: const Text("Category"),
              value: category,
              onChanged: (newValue) {
                setState(() {
                  // Check if the selected value is the same as the hint (default value)
                  // If yes, set the category to null, otherwise set it to the selected value
                  category = (newValue == "Category") ? null : newValue;
                });
              },
              items: [
                "Category", // Add the hint (default value) as the first item in the list
                ...categories!,
              ].map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            const SizedBox(width: 16),
            DropdownButton<String>(
              hint: const Text("Difficulty"),
              value: difficulty,
              onChanged: (newValue) {
                setState(() {
                  difficulty = (newValue == "Difficulty") ? null : newValue;
                });
              },
              items: [
                "Difficulty",
                ...difficulties!,
              ].map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            const SizedBox(width: 16),
            DropdownButton<String>(
              hint: const Text("Target"),
              value: target,
              onChanged: (newValue) {
                setState(() {
                  target = (newValue == "Target") ? null : newValue;
                });
              },
              items: [
                "Target",
                ...targets!,
              ].map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              // Build the list item using the filtered data
              return ExerciseListTile(exercise: filteredData[index], parentListener: widget.parentListener,);
            },
          ),
        ),
      ],
    );
  }

  void extractTargets(List<Exercise> dataList) {
    List<String> tempTargets = [];

    dataList.where((exercise) => exercise.target != null).forEach((exercise) {
      if (exercise.target!.primary != null) {
        if (exercise.target!.primary!.length > 1) {
          tempTargets.addAll(exercise.target!.primary!);
        } else {
          tempTargets.add(exercise.target!.primary!
              .toString()
              .replaceAll("[", "")
              .replaceAll("]", ""));
        }
      }
    });

    setState(() {
      targets = tempTargets.toSet().toList();
    });
  }
}
