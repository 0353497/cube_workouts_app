import 'dart:async';

import 'package:cube_workouts/domain/bloc/workout_bloc.dart';
import 'package:cube_workouts/domain/bloc/workout_events.dart';
import 'package:cube_workouts/presentation/widgets/add_workout_floating_action_button.dart';
import 'package:cube_workouts/presentation/widgets/workout_block_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    context.read<WorkoutBloc>().add(const WorkoutsRequested());
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      final query = value.trim();
      context.read<WorkoutBloc>().add(
        query.isEmpty ? const WorkoutsRequested() : WorkoutSearch(query),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBar(
              controller: _searchController,
              hintText: 'Search workouts',
              onChanged: _onSearchChanged,
            ),
            Expanded(
              child: const Stack(
                children: [
                  WorkoutBlockWidget(),
                  Align(
                    alignment: Alignment(.8, .9),
                    child: AddWorkoutFloatingActionButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
