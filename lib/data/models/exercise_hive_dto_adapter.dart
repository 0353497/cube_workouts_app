import 'package:cube_workouts/data/models/exercise_hive_dto.dart';
import 'package:hive/hive.dart';

class ExerciseHiveDtoAdapter extends TypeAdapter<ExerciseHiveDto> {
  @override
  final int typeId = 1;

  @override
  ExerciseHiveDto read(BinaryReader reader) {
    final id = reader.readInt();
    final name = reader.readString();
    final sets = reader.read() as int?;
    final reps = reader.read() as int?;
    final durationInSeconds = reader.read() as int?;

    return ExerciseHiveDto(
      id: id,
      name: name,
      sets: sets,
      reps: reps,
      durationInSeconds: durationInSeconds,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseHiveDto obj) {
    writer
      ..writeInt(obj.id)
      ..writeString(obj.name)
      ..write(obj.sets)
      ..write(obj.reps)
      ..write(obj.durationInSeconds);
  }
}
