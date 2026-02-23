import 'package:cube_workouts/domain/models/exercise.dart';
import 'package:cube_workouts/domain/bloc/workout_events.dart';

sealed class ExerciseEvent extends WorkoutEvent {
  const ExerciseEvent();
}

class ExerciseRequested extends ExerciseEvent {
  const ExerciseRequested(this.workoutId);
  final int workoutId;
}

class ExerciseAdded extends ExerciseEvent {
  final Exercise exercise;
  final int workoutId;

  const ExerciseAdded(this.exercise, this.workoutId);
}

class ExerciseUpdated extends ExerciseEvent {
  final Exercise exercise;
  final int workoutId;

  const ExerciseUpdated(this.exercise, this.workoutId);
}

class ExerciseDeleted extends ExerciseEvent {
  final int exerciseId;
  final int workoutId;
  const ExerciseDeleted(this.exerciseId, this.workoutId);
}
