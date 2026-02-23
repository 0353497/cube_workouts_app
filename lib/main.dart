import 'package:cube_workouts/core/routing/app_router.dart';
import 'package:cube_workouts/data/repositories/local_workout_repository.dart';
import 'package:cube_workouts/domain/bloc/workout_bloc.dart';
import 'package:cube_workouts/domain/repositories/workout_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final WorkoutRepository repository = LocalWorkoutRepository();
  await repository.init();

  runApp(
    BlocProvider(
      create: (_) => WorkoutBloc(repository),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
