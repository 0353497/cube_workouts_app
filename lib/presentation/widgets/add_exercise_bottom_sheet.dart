import 'package:cube_workouts/domain/bloc/exercise_events.dart';
import 'package:cube_workouts/domain/bloc/workout_bloc.dart';
import 'package:cube_workouts/domain/bloc/workout_state.dart';
import 'package:cube_workouts/domain/models/exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExerciseBottomSheet extends StatefulWidget {
  const AddExerciseBottomSheet({super.key, required this.workoutId});

  final int workoutId;

  @override
  State<AddExerciseBottomSheet> createState() => _AddExerciseBottomSheetState();
}

class _AddExerciseBottomSheetState extends State<AddExerciseBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();
  Duration _selectedDuration = Duration.zero;

  @override
  void dispose() {
    _nameController.dispose();
    _setsController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  void _changeSets(int delta) {
    final currentValue = int.tryParse(_setsController.text.trim()) ?? 0;
    final nextValue = (currentValue + delta).clamp(0, 999);
    _setsController.text = nextValue.toString();
  }

  void _changeReps(int delta) {
    final currentValue = int.tryParse(_repsController.text.trim()) ?? 0;
    final nextValue = (currentValue + delta).clamp(0, 999);
    _repsController.text = nextValue.toString();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final state = context.read<WorkoutBloc>().state;
    var nextExerciseId = DateTime.now().millisecondsSinceEpoch;

    if (state is WorkoutDetailLoaded && state.workout.exercises.isNotEmpty) {
      final maxId = state.workout.exercises
          .map((exercise) => exercise.id)
          .reduce((a, b) => a > b ? a : b);
      nextExerciseId = maxId + 1;
    }

    final sets = int.tryParse(_setsController.text.trim());
    final reps = int.tryParse(_repsController.text.trim());

    final exercise = Exercise(
      id: nextExerciseId,
      name: _nameController.text.trim(),
      sets: sets,
      reps: reps,
      duration: _selectedDuration == Duration.zero ? null : _selectedDuration,
    );

    context.read<WorkoutBloc>().add(ExerciseAdded(exercise, widget.workoutId));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Exercise',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _setsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Sets (optional)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _changeSets(1);
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _changeSets(-1);
                      });
                    },
                    icon: Icon(Icons.minimize),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _repsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Reps (optional)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _changeReps(1);
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _changeReps(-1);
                      });
                    },
                    icon: Icon(Icons.minimize),
                  ),
                ],
              ),
              Text(
                'Duration (optional)',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: 150,
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.ms,
                  initialTimerDuration: _selectedDuration,
                  onTimerDurationChanged: (duration) {
                    setState(() {
                      _selectedDuration = duration;
                    });
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Save Exercise'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
