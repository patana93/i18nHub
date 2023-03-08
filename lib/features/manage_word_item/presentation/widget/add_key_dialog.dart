import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/word_item_key_validator_controller.dart';
import 'package:i18n_app/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/word_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';

class AddKeyDialog extends ConsumerWidget {
  final WordModel? wordItemEdit;
  // final ScrollController scrollController;
  final String searchString;
  const AddKeyDialog(
      {
      //required this.scrollController,
      this.wordItemEdit,
      required this.searchString,
      super.key});

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
                      .read(manageWordItemControllerProvider.notifier)
                      .checkWordItemKeyAlreadyExist(
                          key: textEditingController3.text)) {
                return;
              }
              final languages = ref.read(manageLanguageControllerProvider);

              if (wordItemEdit == null) {
                ref.read(manageWordItemControllerProvider.notifier).addWordItem(
                    wordItem: WordModel(
                      key: textEditingController3.text,
                      translations: {
                        for (final lan in languages)
                          TranslationModel(language: lan, value: "")
                      },
                    ),
                    searchString: searchString);
              } else {
                ref
                    .read(manageWordItemControllerProvider.notifier)
                    .editWordItemKey(
                        oldKey: wordItemEdit!.key,
                        newWordItem: WordModel(
                            key: textEditingController3.text,
                            translations: wordItemEdit!.translations),
                        searchString: searchString);
              }

              //  await Scrollable.ensureVisible(context);

              //  scrollController
              //      .animateTo(
              //    scrollController.position.maxScrollExtent + 50,
              //    duration: const Duration(milliseconds: 300),
              //    curve: Curves.easeOut,
              //  )
              //      .whenComplete(() {
              textEditingController3.text = "";
              Navigator.of(context).pop();
              //});
            },
            child: const Text("Save"))
      ],
      content: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return (ref
              .read(validateKeyControllerProvider.notifier)
              .validate(value));
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
