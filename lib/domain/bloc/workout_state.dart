import 'package:cube_workouts/domain/models/workout.dart';

abstract class WorkoutState {}

class WorkoutInitial extends WorkoutState {}

class WorkoutLoading extends WorkoutState {}

class WorkoutLoaded extends WorkoutState {
  final List<Workout> workouts;

  WorkoutLoaded(this.workouts);
}

class WorkoutDetailLoaded extends WorkoutState {
  final Workout workout;

  WorkoutDetailLoaded(this.workout);
}

class WorkoutEmpty extends WorkoutState {}

class WorkoutError extends WorkoutState {
  final String message;

  WorkoutError(this.message);
}
