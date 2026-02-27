import 'dart:async';

import 'package:cube_workouts/domain/models/exercise.dart';
import 'package:cube_workouts/domain/models/workout.dart';

abstract class WorkoutRepository {
  Future<void> init();

  Future<List<Workout>> getWorkouts();
  Future<List<Workout>> getFavoriteWorkouts();
  Future<List<Workout>> searchWorkouts(String query);

  Future<Workout> getWorkout(int workoutId);
  Future<void> addWorkout(Workout workout);
  Future<void> updateWorkout(Workout newWorkout);
  Future<void> deleteWorkout(int workoutId);
  Future<void> toggleFavorite(int workoutId);

  Future<void> addExercise(int workoutId, Exercise exercise);
  Future<void> updateExercise(int workoutId, Exercise exercise);
  Future<void> deleteExercise(int workoutId, int exerciseId);

  Future<Workout> deepCopyWorkout(int workoutId);
}
