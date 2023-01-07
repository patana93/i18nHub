import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/models/translation_model.dart';

import '../models/word_item.dart';

class AddKeyDialog extends ConsumerWidget {
  final WordModel? wordItemEdit;
  final ScrollController scrollController;
  const AddKeyDialog(
      {required this.scrollController, this.wordItemEdit, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textEditingController3 =
        TextEditingController();
    if (wordItemEdit != null) {
      textEditingController3.text = wordItemEdit!.key;
    }
    return AlertDialog(
      title: Text(wordItemEdit == null ? "Add key" : "Edit key"),
      actions: [
        TextButton(
            onPressed: () async {
              if (textEditingController3.text.isEmpty ||
                  textEditingController3.text.contains(" ") ||
                  ref
                      .read(wordNotifierProvider.notifier)
                      .checkKeyAlreadyExist(textEditingController3.text)) {
                return;
              }
              if (wordItemEdit == null) {
                ref.read(wordNotifierProvider.notifier).addWord(WordModel(
                      key: textEditingController3.text,
                      translations: const [],
                    ));
              } else {
                ref.read(wordNotifierProvider.notifier).editWordKey(
                    wordItemEdit!.key,
                    WordModel(
                        key: textEditingController3.text,
                        translations: wordItemEdit!.translations));
              }

              await Scrollable.ensureVisible(context);

              scrollController
                  .animateTo(
                scrollController.position.maxScrollExtent + 50,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              )
                  .whenComplete(() {
                textEditingController3.text = "";
                Navigator.of(context).pop();
              });
            },
            child: const Text("Save"))
      ],
      content: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter a valid key";
          }
          if (value.contains(" ")) {
            return "Key cannot contain any space";
          }
          if (ref
              .read(wordNotifierProvider.notifier)
              .checkKeyAlreadyExist(value)) {
            return "Key already used";
          }
          return null;
        },
        controller: textEditingController3,
        decoration: const InputDecoration(
            hintText: 'Enter the key',
            hintStyle: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(8),
            ))),
      ),
    );
  }
}
