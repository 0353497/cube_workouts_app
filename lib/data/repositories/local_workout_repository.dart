import 'package:cube_workouts/data/initial_data/initial_data.dart';
import 'package:cube_workouts/data/repositories/hive_adapter_registry.dart';
import 'package:cube_workouts/domain/models/exercise.dart';
import 'package:cube_workouts/domain/models/workout.dart';
import 'package:cube_workouts/domain/repositories/workout_repository.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalWorkoutRepository implements WorkoutRepository {
  @override
  Future<void> init() async {
    final path = await getApplicationDocumentsDirectory();
    Hive.init(path.path);

    registerWorkoutHiveAdapters();

    _workoutBox = await Hive.openBox<Workout>('workouts');
    if (_workoutBox.isEmpty) _workoutBox.addAll(initialData);
  }

  late final Box<Workout> _workoutBox;

  @override
  Future<void> addExercise(int workoutId, Exercise exercise) {
    // TODO: implement addExercise
    throw UnimplementedError();
  }

  @override
  Future<void> addWorkout(Workout workout) {
    // TODO: implement addWorkout
    throw UnimplementedError();
  }

  @override
  Future<void> deleteExercise(int workoutId, int exerciseId) {
    // TODO: implement deleteExercise
    throw UnimplementedError();
  }

  @override
  Future<void> deleteWorkout(int workoutId) {
    // TODO: implement deleteWorkout
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
  Future<void> updateExercise(int workoutId, Exercise exercise) {
    // TODO: implement updateExercise
    throw UnimplementedError();
  }

  @override
  Future<void> updateWorkout(Workout newWorkout) {
    // TODO: implement updateWorkout
    throw UnimplementedError();
  }
}
