import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_hub/core/utils/colors.dart';
import 'package:i18n_hub/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_hub/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';

import '../../../../core/utils/languages_enum.dart';

class LanguageChip extends ConsumerWidget {
  final bool isDefaultLanguage;
  final String title;
  const LanguageChip(
      {super.key, required this.isDefaultLanguage, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InputChip(
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(2.0),
      label: SizedBox(
        height: 30,
        width: 80,
        child: Center(
          child: Text(
            title,
          ),
        ),
      ),
      labelStyle: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.bold, color: I18nColor.blue),
      selected: false,
      onSelected: null,
      deleteIcon: Icon(
        isDefaultLanguage ? Icons.info : Icons.cancel,
        size: 18,
        color: I18nColor.blue,
      ),
      deleteButtonTooltipMessage: isDefaultLanguage ? "Info" : null,
      onDeleted: isDefaultLanguage
          ? () => _onDeleteDefaultLanguage(context)
          : () => _onDelete(context, ref),
      shape: ContinuousRectangleBorder(
          side: const BorderSide(color: I18nColor.blue),
          borderRadius: BorderRadius.circular(16)),
    );
  }

  _onDeleteDefaultLanguage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              title: Icon(
                Icons.info,
                color: I18nColor.blue,
              ),
              content:
                  Text("This is the main language.\nYou cannot delete it."));
        });
  }

  _onDelete(BuildContext context, WidgetRef ref) {
    final selectedLanguage = LanguagesAvailable.values
        .firstWhere((element) => element.name == title)
        .name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure?"),
        content: RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            const TextSpan(text: "You are deleting "),
            TextSpan(
                text: selectedLanguage,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: " language from all entries"),
          ]),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                ref
                    .read(manageLanguageControllerProvider.notifier)
                    .removeLanguage(selectedLanguage: selectedLanguage);
                ref
                    .read(manageWordItemControllerProvider.notifier)
                    .removeTranslation(selectedLanguage: selectedLanguage);
                Navigator.of(context).pop();
              },
              child: const Text("Confirm")),
        ],
      ),
    );
  }
}
