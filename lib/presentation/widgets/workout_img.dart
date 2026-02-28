import 'dart:io';

import 'package:flutter/material.dart';

class WorkoutImg extends StatelessWidget {
  const WorkoutImg({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final normalizedPath = imagePath.trim();
    final uri = Uri.tryParse(normalizedPath);
    final isFileUri = uri?.scheme == 'file';
    final isAbsoluteFilePath =
        normalizedPath.startsWith('/') ||
        RegExp(r'^[a-zA-Z]:\\').hasMatch(normalizedPath);

    if (isFileUri || isAbsoluteFilePath) {
      debugPrint('Loading local image from path: $imagePath');
      return Image.file(
        isFileUri ? File.fromUri(uri!) : File(normalizedPath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.broken_image, size: 50));
        },
      );
    }
    debugPrint('Loading network image from URL: $imagePath');

    return Image.network(
      imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Icon(Icons.broken_image, size: 50));
      },
    );
  }
}
