import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';

import '../../../../core/utils/languages_enum.dart';

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
        final selectedLanguage = LanguagesAvailable.values
            .firstWhere((element) => element.language == title)
            .language;
        ref
            .read(manageLanguageControllerProvider.notifier)
            .removeLanguage(selectedLanguage: selectedLanguage);
        ref
            .read(manageWordItemControllerProvider.notifier)
            .removeTranslation(selectedLanguage: selectedLanguage);
      },
    );
  }
}
