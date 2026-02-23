import 'package:cube_workouts/presentation/screens/workout_detail_page.dart';
import 'package:cube_workouts/presentation/screens/favorite_page.dart';
import 'package:cube_workouts/presentation/screens/workouts_page.dart';
import 'package:cube_workouts/presentation/widgets/main_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/workouts',
  routes: [
    GoRoute(path: '/', redirect: (context, state) => '/workouts'),
    ShellRoute(
      builder: (context, state, child) {
        final location = state.matchedLocation;
        final currentIndex = location.startsWith('/favorites') ? 1 : 0;
        return MainView(currentIndex: currentIndex, child: child);
      },
      routes: [
        GoRoute(
          path: '/workouts',
          name: 'workouts',
          builder: (context, state) => const WorkoutsPage(),
        ),
        GoRoute(
          path: '/favorites',
          name: 'favorites',
          builder: (context, state) => const FavoritePage(),
        ),
      ],
    ),
    GoRoute(
      path: '/workouts/:workoutId',
      name: 'workoutDetail',
      builder: (context, state) {
        final workoutId = int.parse(state.pathParameters['workoutId']!);
        return WorkoutDetailPage(workoutId: workoutId);
      },
    ),
  ],
);
