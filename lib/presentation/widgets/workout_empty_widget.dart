import 'package:flutter/material.dart';

class WorkoutEmptyWidget extends StatelessWidget {
  const WorkoutEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          Icon(Icons.fitness_center, size: 64, color: Colors.grey),
          Text('No workouts found'),
        ],
      ),
    );
  }
}
