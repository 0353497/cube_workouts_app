import 'package:cube_workouts/domain/models/workout.dart';

abstract class WorkoutEvent {
  const WorkoutEvent();
}

class WorkoutsRequested extends WorkoutEvent {
  const WorkoutsRequested();
}

class FavoriteWorkoutsRequested extends WorkoutEvent {
  const FavoriteWorkoutsRequested();
}

class WorkoutAdded extends WorkoutEvent {
  final Workout workout;

  const WorkoutAdded(this.workout);
}

class WorkoutUpdated extends WorkoutEvent {
  final Workout workout;

  const WorkoutUpdated(this.workout);
}

class WorkoutDeleted extends WorkoutEvent {
  final int workoutId;

  const WorkoutDeleted(this.workoutId);
}
