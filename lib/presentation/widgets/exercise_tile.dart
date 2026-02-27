import 'package:cube_workouts/domain/models/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({super.key, required this.exercise, required this.index});
  final int index;
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(
          exercise.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Wrap(
            spacing: 12,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: _exerciseSubtitle(exercise),
          ),
        ),
      ),
    );
  }

  List<Widget> _exerciseSubtitle(Exercise exercise) {
    final items = <Widget>[];

    if (exercise.duration != null) {
      items.addAll([
        const Icon(Icons.timer_outlined, size: 18),
        Text('${exercise.duration} sec'),
      ]);
    }

    if (exercise.sets != null && exercise.reps != null) {
      items.addAll([
        const Icon(Icons.fitness_center_outlined, size: 18),
        Text('${exercise.sets} sets • ${exercise.reps} reps'),
      ]);
    }

    if (items.isEmpty) {
      items.add(const Text('No details'));
    }

    return items;
  }
}
