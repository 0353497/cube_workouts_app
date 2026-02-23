import 'package:cube_workouts/domain/models/exercise.dart';

class ExerciseHiveDto {
  const ExerciseHiveDto({
    required this.id,
    required this.name,
    this.sets,
    this.reps,
    this.durationInSeconds,
  });

  final int id;

  final String name;

  final int? sets;

  final int? reps;

  final int? durationInSeconds;

  Exercise toDomain() {
    return Exercise(
      id: id,
      name: name,
      sets: sets,
      reps: reps,
      duration: durationInSeconds == null
          ? null
          : Duration(seconds: durationInSeconds!),
    );
  }

  factory ExerciseHiveDto.fromDomain(Exercise exercise) {
    return ExerciseHiveDto(
      id: exercise.id,
      name: exercise.name,
      sets: exercise.sets,
      reps: exercise.reps,
      durationInSeconds: exercise.duration?.inSeconds,
    );
  }
}
