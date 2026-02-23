import 'package:cube_workouts/data/models/exercise_hive_dto.dart';
import 'package:cube_workouts/data/models/workout_hive_dto.dart';
import 'package:hive/hive.dart';

class WorkoutHiveDtoAdapter extends TypeAdapter<WorkoutHiveDto> {
  @override
  final int typeId = 0;

  @override
  WorkoutHiveDto read(BinaryReader reader) {
    final id = reader.readInt();
    final name = reader.readString();
    final exercises = reader.readList().cast<ExerciseHiveDto>();
    final isFavorite = reader.readBool();
    final img = reader.read() as String?;

    return WorkoutHiveDto(
      id: id,
      name: name,
      exercises: exercises,
      isFavorite: isFavorite,
      img: img,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutHiveDto obj) {
    writer
      ..writeInt(obj.id)
      ..writeString(obj.name)
      ..writeList(obj.exercises)
      ..writeBool(obj.isFavorite)
      ..write(obj.img);
  }
}
