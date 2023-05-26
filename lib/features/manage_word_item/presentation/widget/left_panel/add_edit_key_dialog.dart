import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/validate_key_controller.dart';
import 'package:i18n_app/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';

class AddEditKeyDialog extends StatelessWidget {
  final NodeModel nodeItem;
  final WordItem? wordItemEdit;
  // final ScrollController scrollController;
  final String searchString;
  const AddEditKeyDialog(
      {
      //required this.scrollController,
      required this.nodeItem,
      this.wordItemEdit,
      required this.searchString,
      super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController keyEditingController = TextEditingController();
    if (wordItemEdit != null) {
      keyEditingController.text = wordItemEdit!.key;
    }

    return AlertDialog(
      title: Text(wordItemEdit == null ? "Add key" : "Edit key"),
      content: Consumer(builder: (context, ref, child) {
        String? errorMessage = "";
        ref.listen(validateKeyControllerProvider, (previous, next) {
          errorMessage = next;
        });

        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return errorMessage;
          },
          onChanged: (value) {
            ref.read(validateKeyControllerProvider.notifier).validate(value);
          },
          controller: keyEditingController,
          decoration: const InputDecoration(
            errorMaxLines: 2,
            hintText: 'Enter the key',
            hintStyle: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
        );
      }),
      actions: [
        Consumer(
          builder: (context, ref, child) => TextButton(
              onPressed: ref.watch(validateKeyControllerProvider) != null
                  ? null
                  : () {
                      final languages =
                          ref.watch(manageLanguageControllerProvider);

                      if (wordItemEdit == null) {
                        ref
                            .read(manageWordItemControllerProvider.notifier)
                            .addWordItem(
                                nodeItem: nodeItem,
                                wordItem: (
                                  key: keyEditingController.text,
                                  translations: {
                                    for (final lan in languages.keys)
                                      TranslationModel(language: lan, value: "")
                                  }
                                ),
                                searchString: searchString);
                      } else {
                        ref
                            .read(manageWordItemControllerProvider.notifier)
                            .editWordItemKey(
                                newNodeItem: nodeItem,
                                oldKey: wordItemEdit!.key,
                                newWordItem: (
                                  key: keyEditingController.text,
                                  translations: wordItemEdit!.translations
                                ),
                                searchString: searchString);
                      }

                      Navigator.of(context).pop();
                      //  await Scrollable.ensureVisible(context);

                      //  scrollController
                      //      .animateTo(
                      //    scrollController.position.maxScrollExtent + 50,
                      //    duration: const Duration(milliseconds: 300),
                      //    curve: Curves.easeOut,
                      //  )
                      //      .whenComplete(() {
                      //});
                    },
              child: const Text("Save")),
        )
      ],
    );
  }
}
