import 'package:cube_workouts/presentation/widgets/add_workout_bottom_sheet.dart';
import 'package:flutter/material.dart';

class AddWorkoutFloatingActionButton extends StatelessWidget {
  const AddWorkoutFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (context) => const AddWorkoutBottomSheet(),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
