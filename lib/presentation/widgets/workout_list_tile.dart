import 'package:cube_workouts/domain/bloc/workout_bloc.dart';
import 'package:cube_workouts/domain/bloc/workout_events.dart';
import 'package:cube_workouts/domain/models/workout.dart';
import 'package:cube_workouts/presentation/widgets/delete_dismissible.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WorkoutListTile extends StatelessWidget {
  const WorkoutListTile({
    super.key,
    required this.workout,
    required this.onDelete,
  });

  final Workout workout;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return DeleteDismissible(
      dismissKey: ValueKey(workout.id),
      onDelete: onDelete,
      child: ListTile(
        title: Text(workout.name),
        subtitle: Text('${workout.exercises.length} exercises'),
        onTap: () {
          context.pushNamed(
            'workoutDetail',
            pathParameters: {'workoutId': '${workout.id}'},
          );
        },
        trailing: Row(
          spacing: 12,
          children: [
            IconButton(
              onPressed: () {
                context.read<WorkoutBloc>().add(
                  ToggleFavoriteWorkout(workout.id),
                );
              },
              icon: Icon(workout.isFavorite ? Icons.star : Icons.star_border),
            ),
            IconButton(
              onPressed: () {
                context.read<WorkoutBloc>().add(WorkoutCopy(workout.id));
              },
              icon: Icon(Icons.copy),
            ),
          ],
        ),
      ),
    );
  }
}
