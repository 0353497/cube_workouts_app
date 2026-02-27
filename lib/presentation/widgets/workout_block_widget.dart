import 'package:cube_workouts/domain/bloc/workout_bloc.dart';
import 'package:cube_workouts/domain/bloc/workout_events.dart';
import 'package:cube_workouts/domain/bloc/workout_state.dart';
import 'package:cube_workouts/presentation/widgets/workout_card.dart';
import 'package:cube_workouts/presentation/widgets/workout_empty_widget.dart';
import 'package:cube_workouts/presentation/widgets/workout_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutBlockWidget extends StatelessWidget {
  const WorkoutBlockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBloc, WorkoutState>(
      builder: (context, state) {
        if (state is WorkoutError) {
          return WorkoutErrorWidget(msg: state.message);
        }

        if (state is WorkoutLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is WorkoutLoaded) {
          final workouts = state.workouts;
          if (workouts.isEmpty) {
            return const WorkoutEmptyWidget();
          }

          return ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return WorkoutCard(
                workout: workout,
                onDelete: () {
                  context.read<WorkoutBloc>().add(WorkoutDeleted(workout.id));
                },
              );
            },
          );
        }
        if (state is WorkoutEmpty) {
          return WorkoutEmptyWidget();
        }

        return const SizedBox.shrink();
      },
    );
  }
}
