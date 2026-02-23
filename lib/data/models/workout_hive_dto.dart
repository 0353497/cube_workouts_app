import 'package:cube_workouts/data/models/exercise_hive_dto.dart';
import 'package:cube_workouts/domain/models/workout.dart';

class WorkoutHiveDto {
  const WorkoutHiveDto({
    required this.id,
    required this.name,
    required this.exercises,
    required this.isFavorite,
    this.img,
  });

  final int id;

  final String name;

  final List<ExerciseHiveDto> exercises;

  final bool isFavorite;

  final String? img;

  Workout toDomain() {
    return Workout(
      id: id,
      name: name,
      exercises: exercises.map((exercise) => exercise.toDomain()).toList(),
      isFavorite: isFavorite,
      img: img,
    );
  }

  factory WorkoutHiveDto.fromDomain(Workout workout) {
    return WorkoutHiveDto(
      id: workout.id,
      name: workout.name,
      exercises: workout.exercises
          .map((exercise) => ExerciseHiveDto.fromDomain(exercise))
          .toList(),
      isFavorite: workout.isFavorite,
      img: workout.img,
    );
  }
}
