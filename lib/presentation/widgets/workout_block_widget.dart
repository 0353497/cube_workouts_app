import 'package:cube_workouts/domain/bloc/workout_bloc.dart';
import 'package:cube_workouts/domain/bloc/workout_events.dart';
import 'package:cube_workouts/domain/bloc/workout_state.dart';
import 'package:cube_workouts/presentation/widgets/workout_card.dart';
import 'package:cube_workouts/presentation/widgets/workout_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WorkoutBlockWidget extends StatelessWidget {
  const WorkoutBlockWidget({super.key});

  void _requestCurrentList(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final isFavoritesRoute = location.startsWith('/favorites');
    context.read<WorkoutBloc>().add(
      isFavoritesRoute
          ? const FavoriteWorkoutsRequested()
          : const WorkoutsRequested(),
    );
  }

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
            return const Center(child: Text('No workouts found'));
          }

          return ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return WorkoutCard(workout: workout);
            },
          );
        }

        if (state is WorkoutDetailLoaded || state is WorkoutInitial) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!context.mounted) {
              return;
            }
            _requestCurrentList(context);
          });

          return const Center(child: CircularProgressIndicator());
        }

        return const SizedBox.shrink();
      },
    );
  }
}
