import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/models/language_selected.dart';
import 'package:i18n_app/models/text_cursor_position.dart';
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
                    text: selectedWordItem
                        .translations[selectedLanguages.elementAt(index)])
                  ..selection = TextSelection.collapsed(
                      offset: _calculateOffset(
                          ref,
                          selectedWordItem.translations[
                              selectedLanguages.elementAt(index)]));

                return ListTile(
                  title: TextField(
                    decoration: InputDecoration(
                        helperText: selectedLanguages.elementAt(index)),
                    controller: languageTextController,
                    onChanged: (value) {
                      ref
                          .read(wordItemNotifierProvider.notifier)
                          .editWordTranslation(
                              selectedWordItem.key,
                              WordItem(
                                  key: selectedWordItem.key,
                                  translations: {
                                    selectedLanguages.elementAt(index): value
                                  }));
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
