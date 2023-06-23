import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/core/controller/text_cursor_position.dart';
import 'package:i18n_app/core/utils/colors.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/translation_edit_text_focus_controller.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Expanded(
            flex: 93,
            child: ListTile(
              title: GestureDetector(
                onPanDown: (_) => ref
                    .read(translationEditTextFocusNotifierProvider.notifier)
                    .setEdtiTextIndex(index),
                child: TextField(
                  onTap: () {
                    ref
                        .read(translationEditTextFocusNotifierProvider.notifier)
                        .setEdtiTextIndex(index);
                  },
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                    ref
                        .read(translationEditTextFocusNotifierProvider.notifier)
                        .setEdtiTextIndex(-1);
                  },
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          (ref.watch(translationEditTextFocusNotifierProvider) ??
                                      -1) ==
                                  index
                              ? Colors.black
                              : Colors.grey),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  enabled: index == 0
                      ? true
                      : !selectedItem.translations
                          .elementAt(index)
                          .isEqualToDefault,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.only(
                        top: 30, bottom: 12, left: 12, right: 12),
                    hintText: "Empty...",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(
                            color: Colors.grey, fontStyle: FontStyle.italic),
                    labelText: selectedLanguage,
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                      (Set<MaterialState> states) {
                        return states.contains(MaterialState.focused)
                            ? const TextStyle(
                                color: I18nColor.blue,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)
                            : const TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              );
                      },
                    ),
                  ),
                  controller: languageTextController,
                  onChanged: (value) {
                    ref
                        .read(manageWordItemControllerProvider.notifier)
                        .editWordTranslation(
                            nodeItem: selectedNode!,
                            key: selectedItem.key,
                            newTranslation: TranslationModel(
                              languageName: selectedLanguage,
                              value: value,
                            ));
                    ref
                        .read(textCursorPositionNotifierProvider.notifier)
                        .setTextCursorPosition(
                            languageTextController.selection.baseOffset);
                  },
                ),
              ),
            ),
          ),
          index != 0 && selectedNode != null
              ? Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      Switch(
                        thumbColor:
                            const MaterialStatePropertyAll(Colors.white),
                        value: selectedItem.translations.isEmpty
                            ? false
                            : selectedItem.translations
                                .elementAt(index)
                                .isEqualToDefault,
                        onChanged: (value) {
                          ref
                              .read(manageWordItemControllerProvider.notifier)
                              .editWordTranslation(
                                  nodeItem: selectedNode,
                                  key: selectedItem.key,
                                  newTranslation: TranslationModel(
                                    languageName: selectedLanguage,
                                    value: selectedItem.translations
                                        .elementAt(0)
                                        .value,
                                  ),
                                  isEqualToDefault: value);
                        },
                      ),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "Copy\nmain",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                )
              : Expanded(
                  flex: 7,
                  child: Text(
                    "Main\nlanguage",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                ),
        ],
      ),
    );
  }
}


/* class InputDecoratorExample extends StatelessWidget {
  const InputDecoratorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Name',
        // The MaterialStateProperty's value is a text style that is orange
        // by default, but the theme's error color if the input decorator
        // is in its error state.
        labelStyle: MaterialStateTextStyle.resolveWith(
          (Set<MaterialState> states) {
            final Color color = states.contains(MaterialState.error)
                ? Theme.of(context).colorScheme.error
                : Colors.orange;
            return TextStyle(color: color, letterSpacing: 1.3);
          },
        ),
      ),
      validator: (String? value) {
        if (value == null || value == '') {
          return 'Enter name';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.always,
    );
  }
} */
