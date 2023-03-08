import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultLanguageChip extends ConsumerWidget {
  final String title;
  const DefaultLanguageChip({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InputChip(
      disabledColor: Colors.blue[100],
      labelStyle: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      padding: const EdgeInsets.all(2.0),
      label: Text(
        title,
      ),
      selected: false,
      selectedColor: Colors.blue.shade600,
      onSelected: null,
    );
  }
}
