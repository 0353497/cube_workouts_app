import 'package:cube_workouts/domain/bloc/workout_bloc.dart';
import 'package:cube_workouts/domain/bloc/exercise_events.dart';
import 'package:cube_workouts/domain/bloc/workout_events.dart';
import 'package:cube_workouts/domain/bloc/workout_state.dart';
import 'package:cube_workouts/presentation/widgets/add_exercise_bottom_sheet.dart';
import 'package:cube_workouts/presentation/widgets/exercise_tile.dart';
import 'package:cube_workouts/presentation/widgets/workout_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WorkoutDetailPage extends StatefulWidget {
  const WorkoutDetailPage({super.key, required this.workoutId});
  final int workoutId;

  @override
  State<WorkoutDetailPage> createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  final _nameFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isEditingName = false;

  @override
  void initState() {
    super.initState();

    context.read<WorkoutBloc>().add(GetWorkout(widget.workoutId));
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startEditingName(String currentName) {
    setState(() {
      _isEditingName = true;
      _nameController.text = currentName;
    });
  }

  void _cancelEditingName() {
    setState(() {
      _isEditingName = false;
      _nameController.clear();
    });
  }

  void _saveWorkoutName(workout) {
    if (!_nameFormKey.currentState!.validate()) {
      return;
    }

    final updatedName = _nameController.text.trim();
    context.read<WorkoutBloc>().add(
      WorkoutUpdated(workout.copyWith(name: updatedName)),
    );
    setState(() {
      _isEditingName = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            final lastLocation = GoRouter.of(
              context,
            ).routerDelegate.currentConfiguration.last;
            bool ifFromFavorites = lastLocation.route.path == '/favorites';
            if (ifFromFavorites) {
              context.read<WorkoutBloc>().add(
                const FavoriteWorkoutsRequested(),
              );
            } else {
              context.read<WorkoutBloc>().add(const WorkoutsRequested());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (context) =>
                AddExerciseBottomSheet(workoutId: widget.workoutId),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          if (state is WorkoutLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WorkoutError) {
            return Center(child: Text(state.message));
          }

          if (state is WorkoutDetailLoaded) {
            final workout = state.workout;
            if (!_isEditingName) {
              _nameController.text = workout.name;
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (workout.img != null)
                    AspectRatio(
                      aspectRatio: 3 / 2,
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(12),
                        child: WorkoutImg(imagePath: workout.img!),
                      ),
                    ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _isEditingName
                            ? Form(
                                key: _nameFormKey,
                                child: TextFormField(
                                  controller: _nameController,
                                  autofocus: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Workout name',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Name is required';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (_) {
                                    _saveWorkoutName(workout);
                                  },
                                ),
                              )
                            : Text(
                                workout.name,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                      ),
                      if (_isEditingName) ...[
                        IconButton(
                          onPressed: () => _saveWorkoutName(workout),
                          icon: const Icon(Icons.check),
                        ),
                        IconButton(
                          onPressed: _cancelEditingName,
                          icon: const Icon(Icons.close),
                        ),
                      ] else
                        IconButton(
                          onPressed: () => _startEditingName(workout.name),
                          icon: const Icon(Icons.edit),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Exercises:',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ReorderableListView.builder(
                      itemCount: workout.exercises.length,
                      onReorder: (oldIndex, newIndex) {
                        context.read<WorkoutBloc>().add(
                          ExerciseReordered(
                            widget.workoutId,
                            oldIndex,
                            newIndex,
                          ),
                        );
                      },
                      itemBuilder: (context, index) {
                        final exercise = workout.exercises[index];
                        return Container(
                          key: ValueKey(exercise.id),
                          child: ExerciseTile(
                            exercise: exercise,
                            index: index,
                            onDelete: () {
                              context.read<WorkoutBloc>().add(
                                ExerciseDeleted(exercise.id, widget.workoutId),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('Workout not found'));
        },
      ),
    );
  }
}
