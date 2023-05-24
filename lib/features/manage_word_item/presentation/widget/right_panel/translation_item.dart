import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/core/controller/text_cursor_position.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';

class TranslationItem extends ConsumerWidget {
  final int index;
  final WordItem selectedItem;
  final TextEditingController languageTextController;
  final String selectedLanguage;
  const TranslationItem(
      {required this.index,
      required this.selectedItem,
      required this.languageTextController,
      required this.selectedLanguage,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNode =
        ref.read(selectionWordItemControllerProvider.notifier).selectedNode;
    return ListTile(
      trailing: Visibility(
        visible: index != 0 && selectedNode != null,
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
                      .read(manageWordItemControllerProvider.notifier)
                      .editWordTranslation(
                          nodeItem: selectedNode!,
                          key: selectedItem.key,
                          newTranslation: TranslationModel(
                            language: selectedLanguage,
                            value: selectedItem.translations.elementAt(0).value,
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
            : !selectedItem.translations.elementAt(index).isEqualToDefault,
        decoration: InputDecoration(labelText: selectedLanguage),
        controller: languageTextController,
        onChanged: (value) {
          ref
              .read(manageWordItemControllerProvider.notifier)
              .editWordTranslation(
                  nodeItem: selectedNode!,
                  key: selectedItem.key,
                  newTranslation: TranslationModel(
                    language: selectedLanguage,
                    value: value,
                  ));
          ref
              .read(textCursorPositionNotifierProvider.notifier)
              .setTextCursorPosition(
                  languageTextController.selection.baseOffset);
        },
      ),
    );
  }
}
