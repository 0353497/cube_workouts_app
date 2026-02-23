import 'package:cube_workouts/data/models/exercise_hive_dto_adapter.dart';
import 'package:cube_workouts/data/models/workout_hive_dto_adapter.dart';
import 'package:hive/hive.dart';

void registerWorkoutHiveAdapters() {
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(ExerciseHiveDtoAdapter());
  }
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(WorkoutHiveDtoAdapter());
  }
}
