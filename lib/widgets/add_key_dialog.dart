import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/word_item.dart';

class AddKeyDialog extends ConsumerWidget {
  final String? keyEdit;
  final ScrollController scrollController;
  const AddKeyDialog({required this.scrollController, this.keyEdit, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textEditingController3 =
        TextEditingController();
    if (keyEdit != null) {
      textEditingController3.text = keyEdit!;
    }
    return AlertDialog(
      title: Text(keyEdit == null ? "Add key" : "Edit key"),
      actions: [
        TextButton(
            onPressed: () async {
              if (textEditingController3.text.isEmpty ||
                  textEditingController3.text.contains(" ") ||
                  ref
                      .read(wordItemNotifierProvider.notifier)
                      .checkKeyAlreadyExist(textEditingController3.text)) {
                return;
              }
              if (keyEdit == null) {
                ref.read(wordItemNotifierProvider.notifier).addWord(WordItem(
                    key: textEditingController3.text, translations: const {}));
              } else {
                ref.read(wordItemNotifierProvider.notifier).editWord(
                    keyEdit!,
                    WordItem(
                        key: textEditingController3.text,
                        translations: const {}));
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
              .read(wordItemNotifierProvider.notifier)
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
