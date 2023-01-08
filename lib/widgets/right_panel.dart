import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/models/language_selected.dart';
import 'package:i18n_app/models/text_cursor_position.dart';
import 'package:i18n_app/models/translation_model.dart';
import 'package:i18n_app/models/word_item.dart';

class RightPanel extends ConsumerWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedWordItem = ref.watch(wordItemSelectedNotifierProvider);
    final selectedLanguages = ref.watch(languageSelectedNotifierProvider);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(28),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          width: 1,
          style: BorderStyle.solid,
          color: Colors.black.withAlpha(125),
        ),
      ),
      child: selectedWordItem == null
          ? const SizedBox(width: double.infinity, child: Text("no selection"))
          : ListView.builder(
              itemCount: selectedLanguages.length,
              itemBuilder: (context, index) {
                final languageTextController = TextEditingController(
                    text: selectedWordItem.translations.isEmpty
                        ? ""
                        : selectedWordItem.translations[index].isEqualToDefault
                            ? selectedWordItem.translations[0].value
                            : selectedWordItem.translations[index].value);
                try {
                  //TODO TRY NOT REQUIRED AND USE .value option to change text and selection
                  //could resolve the issue
                  final a = TextSelection.collapsed(
                      offset: _calculateOffset(
                          ref,
                          selectedWordItem.translations.isEmpty
                              ? ""
                              : selectedWordItem.translations[index].value));
                  languageTextController.value = TextEditingValue(
                      text: selectedWordItem.translations.isEmpty
                          ? ""
                          : selectedWordItem
                                  .translations[index].isEqualToDefault
                              ? selectedWordItem.translations[0].value
                              : selectedWordItem.translations[index].value,
                      selection: a);
                } on Exception catch (e) {
                  log(e.toString());
                  languageTextController.selection =
                      const TextSelection.collapsed(
                    offset: 0,
                  );
                }

                return ListTile(
                  trailing: Visibility(
                    visible: index != 0,
                    child: Column(
                      children: [
                        Expanded(
                          child: Switch(
                            value: selectedWordItem.translations.isEmpty
                                ? false
                                : selectedWordItem
                                    .translations[index].isEqualToDefault,
                            onChanged: (value) {
                              ref
                                  .read(wordNotifierProvider.notifier)
                                  .editWordTranslation(
                                      wordItem: selectedWordItem,
                                      newTranslation: TranslationModel(
                                        language:
                                            selectedLanguages.elementAt(index),
                                        value: selectedWordItem
                                            .translations[0].value,
                                      ),
                                      isEqualToDefault: value);
                            },
                          ),
                        ),
                        const Expanded(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              "Copy\nDefault",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  title: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    enabled: index == 0
                        ? true
                        : !selectedWordItem
                            .translations[index].isEqualToDefault,
                    decoration: InputDecoration(
                        labelText: selectedLanguages.elementAt(index)),
                    controller: languageTextController,
                    onChanged: (value) {
                      ref
                          .read(wordNotifierProvider.notifier)
                          .editWordTranslation(
                              wordItem: selectedWordItem,
                              newTranslation: TranslationModel(
                                language: selectedLanguages.elementAt(index),
                                value: value,
                              ));
                      ref
                          .read(textCursorPositionNotifierProvider.notifier)
                          .setTextCursorPosition(
                              languageTextController.selection.baseOffset);
                    },
                  ),
                );
              },
            ),
    );
  }

  int _calculateOffset(WidgetRef ref, String? text) {
    if ((text?.length ?? 0) < ref.watch(textCursorPositionNotifierProvider)) {
      return 0;
    }
    return ref.read(textCursorPositionNotifierProvider);
  }
}
