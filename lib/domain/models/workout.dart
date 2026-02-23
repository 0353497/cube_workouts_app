import 'package:cube_workouts/domain/models/exercise.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout.freezed.dart';
part 'workout.g.dart';

@freezed
abstract class Workout with _$Workout {
  const factory Workout({
    required int id,
    required String name,
    required List<Exercise> exercises,
    @Default(false) bool isFavorite,
    String? img,
  }) = _Workout;

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);
}

//dart run build_runner build --delete-conflicting-outputs
