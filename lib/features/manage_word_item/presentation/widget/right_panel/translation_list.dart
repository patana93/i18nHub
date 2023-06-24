import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_hub/core/controller/text_cursor_position.dart';
import 'package:i18n_hub/core/utils/colors.dart';
import 'package:i18n_hub/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_hub/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_hub/features/manage_word_item/presentation/widget/right_panel/translation_item.dart';

class TranslationList extends ConsumerWidget {
  final WordItem selectedItem;
  const TranslationList({required this.selectedItem, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguages = ref.watch(manageLanguageControllerProvider);
    return Column(
      children: [
        Flexible(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              selectedItem.key,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: I18nColor.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Expanded(
            flex: 5,
            child: SizedBox(
              height: 1,
            )),
        Expanded(
          flex: 85,
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
                          : selectedItem.translations.elementAt(index).value);

              try {
                //TODO TRY NOT REQUIRED AND USE .value option to change text and selection
                //could resolve the issue
                final selection = TextSelection.collapsed(
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
                            ? selectedItem.translations.elementAt(0).value
                            : selectedItem.translations.elementAt(index).value,
                    selection: selection);
              } on Exception catch (_) {
                languageTextController.selection =
                    const TextSelection.collapsed(
                  offset: 0,
                );
              }

              return TranslationItem(
                index: index,
                selectedItem: selectedItem,
                languageTextController: languageTextController,
                selectedLanguage: selectedLanguages.elementAt(index).name,
              );
            },
          ),
        ),
      ],
    );
  }

  int _calculateOffset(WidgetRef ref, String? text) {
    if ((text?.length ?? 0) < ref.watch(textCursorPositionNotifierProvider)) {
      return 0;
    }
    return ref.read(textCursorPositionNotifierProvider);
  }
}
