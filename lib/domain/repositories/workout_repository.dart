import 'dart:async';

import 'package:cube_workouts/domain/models/exercise.dart';
import 'package:cube_workouts/domain/models/workout.dart';

abstract class WorkoutRepository {
  Future<List<Workout>> getWorkouts();
  Future<List<Workout>> getFavoriteWorkouts();

  Future<Workout> getWorkout(int workoutId);
  Future<void> addWorkout(Workout workout);
  Future<void> updateWorkout(Workout newWorkout);
  Future<void> deleteWorkout(int workoutId);

  Future<void> addExcercise(int workoutId, Exercise exercise);
  Future<void> editExcercise(int workoutId, Exercise exercise);
  Future<void> deleteExercise(int workoutId);
}
