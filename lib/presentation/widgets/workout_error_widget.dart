import 'package:flutter/material.dart';

class WorkoutErrorWidget extends StatelessWidget {
  const WorkoutErrorWidget({super.key, this.msg});
  final String? msg;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          Icon(Icons.warning, color: Colors.redAccent, size: 48),
          Text("something went wrong :("),
          if (msg != null) Text(msg!),
        ],
      ),
    );
  }
}
