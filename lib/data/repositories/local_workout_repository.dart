import 'package:cube_workouts/data/initial_data/initial_data.dart';
import 'package:cube_workouts/data/models/workout_hive_dto.dart';
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

    _workoutBox = await Hive.openBox<WorkoutHiveDto>('workouts');
    if (_workoutBox.isEmpty) {
      await _workoutBox.addAll(
        initialData.map((workout) => WorkoutHiveDto.fromDomain(workout)),
      );
    }
  }

  late final Box<WorkoutHiveDto> _workoutBox;

  @override
  Future<void> addExercise(int workoutId, Exercise exercise) async {
    final Workout workout = await getWorkout(workoutId);
    final updatedWorkout = workout.copyWith(
      exercises: List.from(workout.exercises)..add(exercise),
    );
    await updateWorkout(updatedWorkout);
  }

  @override
  Future<void> addWorkout(Workout workout) async {
    await _workoutBox.add(WorkoutHiveDto.fromDomain(workout));
  }

  @override
  Future<void> deleteExercise(int workoutId, int exerciseId) async {
    final workout = await getWorkout(workoutId);
    final exerciseIndex = _getExerciseIndex(workout, exerciseId);
    final updatedWorkout = workout.copyWith(
      exercises: List.from(workout.exercises)..removeAt(exerciseIndex),
    );
    await updateWorkout(updatedWorkout);
  }

  @override
  Future<void> deleteWorkout(int workoutId) async {
    await _workoutBox.deleteAt(_getWorkoutIndex(workoutId));
  }

  @override
  Future<List<Workout>> getFavoriteWorkouts() async {
    return _workoutBox.values
        .where((workout) => workout.isFavorite)
        .map((workout) => workout.toDomain())
        .toList();
  }

  @override
  Future<Workout> getWorkout(int workoutId) async {
    return _workoutBox.values
        .firstWhere((workout) => workout.id == workoutId)
        .toDomain();
  }

  @override
  Future<List<Workout>> getWorkouts() async {
    return _workoutBox.values.map((workout) => workout.toDomain()).toList();
  }

  @override
  Future<void> updateExercise(int workoutId, Exercise exercise) async {
    final workout = await getWorkout(workoutId);
    final exerciseIndex = _getExerciseIndex(workout, exercise.id);
    final updatedWorkout = workout.copyWith(
      exercises: List.from(workout.exercises)..[exerciseIndex] = exercise,
    );
    await updateWorkout(updatedWorkout);
  }

  @override
  Future<void> updateWorkout(Workout newWorkout) async {
    await _workoutBox.putAt(
      _getWorkoutIndex(newWorkout.id),
      WorkoutHiveDto.fromDomain(newWorkout),
    );
  }

  int _getWorkoutIndex(int workoutId) {
    return _workoutBox.values.toList().indexWhere(
      (workout) => workout.id == workoutId,
    );
  }

  int _getExerciseIndex(Workout workout, int exerciseId) {
    return workout.exercises.indexWhere(
      (exercise) => exercise.id == exerciseId,
    );
  }

  @override
  Future<void> toggleFavorite(int workoutId) async {
    getWorkout(workoutId).then((workout) {
      final updatedWorkout = workout.copyWith(isFavorite: !workout.isFavorite);
      return updateWorkout(updatedWorkout);
    });
  }

  @override
  Future<List<Workout>> searchWorkouts(String query) async {
    final lowerCaseQuery = query.trim().toLowerCase();
    if (lowerCaseQuery.isEmpty) return getWorkouts();

    return _workoutBox.values
        .where(
          (workoutDto) =>
              workoutDto.name.toLowerCase().contains(lowerCaseQuery),
        )
        .map((workoutDto) => workoutDto.toDomain())
        .toList();
  }

  @override
  Future<Workout> deepCopyWorkout(int workoutId) {
    return getWorkout(workoutId).then((workout) {
      final copiedWorkout = workout.copyWith(
        id: DateTime.now().millisecondsSinceEpoch,
        name: '${workout.name} Copy',
        exercises: workout.exercises
            .map(
              (exercise) =>
                  exercise.copyWith(id: DateTime.now().millisecondsSinceEpoch),
            )
            .toList(),
      );
      return addWorkout(copiedWorkout).then((_) => copiedWorkout);
    });
  }
}
