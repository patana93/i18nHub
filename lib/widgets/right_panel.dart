import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/models/language_selected.dart';
import 'package:i18n_app/models/word_item.dart';

class RightPanel extends ConsumerWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = TextEditingController();
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
      child: ListView.builder(
        itemCount: selectedLanguages.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: TextField(
            decoration:
                InputDecoration(helperText: selectedLanguages.elementAt(index)),
            controller: textController,
          ));
        },
      ),
    );
  }
}
