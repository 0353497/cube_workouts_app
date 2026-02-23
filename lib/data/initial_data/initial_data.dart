import 'package:cube_workouts/domain/models/exercise.dart';
import 'package:cube_workouts/domain/models/workout.dart';

const initialData = [
  Workout(
    id: 1,
    name: 'Upper Body Strength',
    exercises: [
      Exercise(id: 1, name: 'Push-Ups', sets: 3, reps: 15),
      Exercise(id: 2, name: 'Bench Press', sets: 4, reps: 10),
    ],
  ),

  Workout(
    id: 2,
    name: 'Cardio Blast',
    exercises: [
      Exercise(id: 3, name: 'Running', duration: Duration(minutes: 30)),
      Exercise(id: 4, name: 'Cycling', duration: Duration(minutes: 20)),
    ],
  ),
];
