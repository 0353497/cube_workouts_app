import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatelessWidget {
  const MainView({super.key, required this.currentIndex, required this.child});
  final int currentIndex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          if (value == 0) context.go("/workouts");
          if (value == 1) context.go("/favorites");
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            label: "workouts",
            tooltip: "workouts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: "favorites",
            tooltip: "favorites",
          ),
        ],
      ),
    );
  }
}
