import 'package:flutter/material.dart';

class DeleteDismissible extends StatelessWidget {
  const DeleteDismissible({
    super.key,
    required this.dismissKey,
    required this.onDelete,
    required this.child,
    this.backgroundMargin,
  });

  final Key dismissKey;
  final VoidCallback onDelete;
  final Widget child;
  final EdgeInsetsGeometry? backgroundMargin;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: dismissKey,
      direction: DismissDirection.endToStart,
      background: Container(
        margin: backgroundMargin,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.delete_outline,
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
      onDismissed: (_) => onDelete(),
      child: child,
    );
  }
}
