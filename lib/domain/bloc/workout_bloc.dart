import 'package:cube_workouts/domain/bloc/workout_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cube_workouts/domain/bloc/workout_state.dart';
import 'package:cube_workouts/domain/repositories/workout_repository.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final WorkoutRepository _repository;

  WorkoutBloc(this._repository) : super(WorkoutInitial()) {
    on<WorkoutsRequested>(_onWorkoutsRequested);
    on<FavoriteWorkoutsRequested>(_onFavoriteWorkoutsRequested);
    on<WorkoutAdded>(_onWorkoutAdded);
    on<WorkoutUpdated>(_onWorkoutUpdated);
    on<WorkoutDeleted>(_onWorkoutDeleted);
  }

  Future<void> _onWorkoutsRequested(
    WorkoutsRequested event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(WorkoutLoading());
    try {
      final workouts = await _repository.getWorkouts();
      emit(WorkoutLoaded(workouts));
    } catch (e) {
      emit(WorkoutError('Failed to load workouts: $e'));
    }
  }

  Future<void> _onFavoriteWorkoutsRequested(
    FavoriteWorkoutsRequested event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(WorkoutLoading());
    try {
      final workouts = await _repository.getFavoriteWorkouts();
      emit(WorkoutLoaded(workouts));
    } catch (e) {
      emit(WorkoutError('Failed to load favorite workouts: $e'));
    }
  }

  Future<void> _onWorkoutAdded(
    WorkoutAdded event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      await _repository.addWorkout(event.workout);
      add(const WorkoutsRequested());
    } catch (e) {
      emit(WorkoutError('Failed to add workout: $e'));
    }
  }

  Future<void> _onWorkoutUpdated(
    WorkoutUpdated event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      await _repository.updateWorkout(event.workout);
      add(const WorkoutsRequested());
    } catch (e) {
      emit(WorkoutError('Failed to update workout: $e'));
    }
  }

  Future<void> _onWorkoutDeleted(
    WorkoutDeleted event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      await _repository.deleteWorkout(event.workoutId);
      add(const WorkoutsRequested());
    } catch (e) {
      emit(WorkoutError('Failed to delete workout: $e'));
    }
  }
}
