import 'package:cube_workouts/domain/bloc/workout_bloc.dart';
import 'package:cube_workouts/domain/bloc/workout_events.dart';
import 'package:cube_workouts/presentation/widgets/add_workout_bottom_sheet.dart';
import 'package:cube_workouts/presentation/widgets/workout_block_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Stack(
      children: [
        const WorkoutBlockWidget(),
        Align(
          alignment: Alignment(.8, .9),
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (context) => const AddWorkoutBottomSheet(),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
