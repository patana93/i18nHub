import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';
import 'package:i18n_app/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';
import 'package:i18n_app/core/controller/text_cursor_position.dart';

class RightPanel extends ConsumerWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguages = ref.watch(manageLanguageControllerProvider);
    final selectedItem = ref.watch(selectionWordItemControllerProvider);
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
      child: selectedItem == null
          ? const SizedBox(width: double.infinity, child: Text("no selection"))
          : Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Text(selectedItem.key),
                ),
                Expanded(
                  flex: 9,
                  child: ListView.builder(
                    itemCount: selectedLanguages.length,
                    itemBuilder: (context, index) {
                      final languageTextController = TextEditingController(
                          text: selectedItem.translations.isEmpty
                              ? ""
                              : selectedItem.translations
                                      .elementAt(index)
                                      .isEqualToDefault
                                  ? selectedItem.translations.elementAt(0).value
                                  : selectedItem.translations
                                      .elementAt(index)
                                      .value);

                      try {
                        //TODO TRY NOT REQUIRED AND USE .value option to change text and selection
                        //could resolve the issue
                        final a = TextSelection.collapsed(
                            offset: _calculateOffset(
                                ref,
                                selectedItem.translations.isEmpty
                                    ? ""
                                    : selectedItem.translations
                                        .elementAt(index)
                                        .value));
                        languageTextController.value = TextEditingValue(
                            text: selectedItem.translations.isEmpty
                                ? ""
                                : selectedItem.translations
                                        .elementAt(index)
                                        .isEqualToDefault
                                    ? selectedItem.translations
                                        .elementAt(0)
                                        .value
                                    : selectedItem.translations
                                        .elementAt(index)
                                        .value,
                            selection: a);
                      } on Exception catch (_) {
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
                                  value: selectedItem.translations.isEmpty
                                      ? false
                                      : selectedItem.translations
                                          .elementAt(index)
                                          .isEqualToDefault,
                                  onChanged: (value) {
                                    ref
                                        .read(manageWordItemControllerProvider
                                            .notifier)
                                        .editWordTranslation(
                                            key: selectedItem.key,
                                            newTranslation: TranslationModel(
                                              language: selectedLanguages.keys
                                                  .elementAt(index),
                                              value: selectedItem.translations
                                                  .elementAt(0)
                                                  .value,
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
                              : !selectedItem.translations
                                  .elementAt(index)
                                  .isEqualToDefault,
                          decoration: InputDecoration(
                              labelText:
                                  selectedLanguages.keys.elementAt(index)),
                          controller: languageTextController,
                          onChanged: (value) {
                            ref
                                .read(manageWordItemControllerProvider.notifier)
                                .editWordTranslation(
                                    key: selectedItem.key,
                                    newTranslation: TranslationModel(
                                      language: selectedLanguages.keys
                                          .elementAt(index),
                                      value: value,
                                    ));
                            ref
                                .read(
                                    textCursorPositionNotifierProvider.notifier)
                                .setTextCursorPosition(languageTextController
                                    .selection.baseOffset);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
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
