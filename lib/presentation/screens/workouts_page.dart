import 'package:cube_workouts/domain/bloc/workout_bloc.dart';
import 'package:cube_workouts/domain/bloc/workout_events.dart';
import 'package:cube_workouts/domain/bloc/workout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  @override
  void initState() {
    super.initState();
    context.read<WorkoutBloc>().add(const WorkoutsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBloc, WorkoutState>(
      builder: (context, state) {
        if (state is WorkoutError) {
          return Center(child: Text(state.message));
        } else if (state is WorkoutLoaded) {
          final workouts = state.workouts;
          if (workouts.isEmpty) {
            return const Center(child: Text('No workouts found'));
          }

          return ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return ListTile(
                title: Text(workout.name),
                subtitle: Text('${workout.exercises.length} exercises'),
                onTap: () {
                  context.pushNamed(
                    'workoutDetail',
                    pathParameters: {'workoutId': '${workout.id}'},
                  );
                },
                trailing: IconButton(
                  onPressed: () {
                    context.read<WorkoutBloc>().add(
                      ToggleFavoriteWorkout(workout.id),
                    );
                  },
                  icon: Icon(
                    workout.isFavorite ? Icons.star : Icons.star_border,
                  ),
                ),
              );
            },
          );
        } else if (state is WorkoutLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('No workouts found'));
        }
      },
    );
  }
}
