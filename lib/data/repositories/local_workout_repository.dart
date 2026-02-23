import 'package:cube_workouts/domain/models/exercise.dart';
import 'package:cube_workouts/domain/models/workout.dart';
import 'package:cube_workouts/domain/repositories/workout_repository.dart';

class LocalWorkoutRepository implements WorkoutRepository {
  @override
  Future<void> addExcercise(int workoutId, Exercise exercise) {
    // TODO: implement addExcercise
    throw UnimplementedError();
  }

  @override
  Future<void> addWorkout(Workout workout) {
    // TODO: implement addWorkout
    throw UnimplementedError();
  }

  @override
  Future<void> deleteExercise(int workoutId) {
    // TODO: implement deleteExercise
    throw UnimplementedError();
  }

  @override
  Future<void> deleteWorkout(int workoutId) {
    // TODO: implement deleteWorkout
    throw UnimplementedError();
  }

  @override
  Future<void> editExcercise(int workoutId, Exercise exercise) {
    // TODO: implement editExcercise
    throw UnimplementedError();
  }

  @override
  Future<List<Workout>> getFavoriteWorkouts() {
    // TODO: implement getFavoriteWorkouts
    throw UnimplementedError();
  }

  @override
  Future<Workout> getWorkout(int workoutId) {
    // TODO: implement getWorkout
    throw UnimplementedError();
  }

  @override
  Future<List<Workout>> getWorkouts() {
    // TODO: implement getWorkouts
    throw UnimplementedError();
  }

  @override
  Future<void> updateWorkout(Workout newWorkout) {
    // TODO: implement updateWorkout
    throw UnimplementedError();
  }
}
