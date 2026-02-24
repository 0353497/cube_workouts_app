import 'dart:async';

import 'package:cube_workouts/domain/bloc/exercise_events.dart';
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
    on<WorkoutSearch>(_onWorkoutSearch);
    on<WorkoutUpdated>(_onWorkoutUpdated);
    on<WorkoutDeleted>(_onWorkoutDeleted);
    on<ExerciseAdded>(_onExerciseAdded);
    on<ExerciseUpdated>(_onExerciseUpdated);
    on<ExerciseDeleted>(_onExerciseDeleted);
    on<ToggleFavoriteWorkout>(_onToggleFavoriteWorkout);
    on<GetWorkout>(_getWorkout);
  }

  Future<void> _onWorkoutsRequested(
    WorkoutsRequested event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(WorkoutLoading());
    try {
      final workouts = await _repository.getWorkouts();
      if (workouts.isEmpty) {
        emit(WorkoutEmpty());
        return;
      }
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
      if (workouts.isEmpty) {
        emit(WorkoutEmpty());
        return;
      }
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

  Future<void> _onExerciseAdded(
    ExerciseAdded event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      await _repository.addExercise(event.workoutId, event.exercise);
      add(const WorkoutsRequested());
    } catch (e) {
      emit(WorkoutError('Failed to add exercise: $e'));
    }
  }

  Future<void> _onExerciseUpdated(
    ExerciseUpdated event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      await _repository.updateExercise(event.workoutId, event.exercise);
      add(const WorkoutsRequested());
    } catch (e) {
      emit(WorkoutError('Failed to update exercise: $e'));
    }
  }

  Future<void> _onExerciseDeleted(
    ExerciseDeleted event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      await _repository.deleteExercise(event.workoutId, event.exerciseId);
      add(const WorkoutsRequested());
    } catch (e) {
      emit(WorkoutError('Failed to delete exercise: $e'));
    }
  }

  FutureOr<void> _onToggleFavoriteWorkout(
    ToggleFavoriteWorkout event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      await _repository.toggleFavorite(event.workoutId);
      add(const WorkoutsRequested());
    } catch (e) {
      emit(WorkoutError('Failed to toggle favorite workout: $e'));
    }
  }

  FutureOr<void> _onWorkoutSearch(
    WorkoutSearch event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(WorkoutLoading());
    try {
      final workouts = await _repository.searchWorkouts(event.query);
      if (workouts.isEmpty) {
        emit(WorkoutEmpty());
        return;
      }
      emit(WorkoutLoaded(workouts));
    } catch (e) {
      emit(WorkoutError('Failed to search workouts: $e'));
    }
  }

  FutureOr<void> _getWorkout(
    GetWorkout event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(WorkoutLoading());
    try {
      final workout = await _repository.getWorkout(event.workoutId);
      emit(WorkoutDetailLoaded(workout));
    } catch (e) {
      emit(WorkoutError('Failed to load workout: $e'));
    }
  }
}
