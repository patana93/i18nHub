import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/language_selected.dart';
import '../models/word_item.dart';
import '../utils/const.dart';

class LanguageChip extends ConsumerWidget {
  final String title;
  const LanguageChip({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InputChip(
      padding: const EdgeInsets.all(2.0),
      label: Text(
        title,
      ),
      selected: false,
      selectedColor: Colors.blue.shade600,
      onSelected: null,
      onDeleted: () {
        ref.read(languageSelectedNotifierProvider.notifier).removeLanguage(
            Const.language.firstWhere((element) => element == title));
        ref.read(wordNotifierProvider.notifier).removeTranslation(
            Const.language.firstWhere((element) => element == title));
      },
    );
  }
}
