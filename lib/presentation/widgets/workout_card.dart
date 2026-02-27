import 'package:cube_workouts/domain/bloc/workout_bloc.dart';
import 'package:cube_workouts/domain/bloc/workout_events.dart';
import 'package:cube_workouts/domain/models/workout.dart';
import 'package:cube_workouts/presentation/widgets/delete_dismissible.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({super.key, required this.workout, required this.onDelete});
  final Workout workout;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    return DeleteDismissible(
      dismissKey: ValueKey(workout.id),
      onDelete: onDelete,
      child: InkWell(
        onTap: () => context.pushNamed(
          'workoutDetail',
          pathParameters: {'workoutId': '${workout.id}'},
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (workout.img != null)
                  AspectRatio(
                    aspectRatio: 3 / 2,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12),
                      child: Image.network(workout.img!, fit: BoxFit.cover),
                    ),
                  ),
                Text(
                  workout.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('${workout.exercises.length} exercises'),

                        IconButton(
                          onPressed: () => context.read<WorkoutBloc>().add(
                            ToggleFavoriteWorkout(workout.id),
                          ),
                          icon: Icon(
                            workout.isFavorite ? Icons.star : Icons.star_border,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
