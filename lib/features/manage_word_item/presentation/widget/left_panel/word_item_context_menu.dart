import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/widget/left_panel/add_edit_key_dialog.dart';

class WordItemContextMenu extends ConsumerWidget {
  final TextEditingController textEditingController;
  final NodeModel nodeItem;
  final WordItem item;
  const WordItemContextMenu(
      {required this.nodeItem,
      required this.item,
      required this.textEditingController,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      splashRadius: 24,
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: const Text("Remove"),
            onTap: () {
              ref
                  .read(manageWordItemControllerProvider.notifier)
                  .removeWordItem(
                      nodeKey: nodeItem.nodeKey,
                      key: item.key,
                      searchString: textEditingController.text);
              ref
                  .read(selectionWordItemControllerProvider.notifier)
                  .selectWordItem(nodeItem, null);
            },
          ),
          PopupMenuItem(
            child: const Text("Rename"),
            onTap: () async {
              await Future.delayed(const Duration(milliseconds: 200))
                  .whenComplete(() => showDialog(
                        context: context,
                        builder: (context) {
                          return AddEditKeyDialog(
                            //scrollController: _scrollController,
                            nodeItem: nodeItem,
                            wordItemEdit: item,
                            searchString: textEditingController.text,
                          );
                        },
                      ));
            },
          ),
          PopupMenuItem(
            child: const Text("Duplicate key"),
            onTap: () {
              WordItem duplicate = item;
              String copyKey = duplicate.key;
              Set<TranslationModel> newTranslations = {};

              for (final newTranslation in item.translations) {
                newTranslations.add(newTranslation.copyWith(
                    value: "", isEqualToDefault: false));
              }

              while (ref
                  .read(manageWordItemControllerProvider.notifier)
                  .checkWordItemKeyAlreadyExist(key: copyKey)) {
                copyKey += "_copy";
              }

              ref.read(manageWordItemControllerProvider.notifier).addWordItem(
                nodeItem: nodeItem,
                wordItem: (
                  key: copyKey,
                  translations: newTranslations,
                ),
              );
            },
          ),
          PopupMenuItem(
            child: const Text("Duplicate all"),
            onTap: () {
              String duplicate = item.key;
              while (ref
                  .read(manageWordItemControllerProvider.notifier)
                  .checkWordItemKeyAlreadyExist(key: duplicate)) {
                duplicate += "_copy";
              }

              ref.read(manageWordItemControllerProvider.notifier).addWordItem(
                nodeItem: nodeItem,
                wordItem: (
                  key: duplicate,
                  translations: item.translations,
                ),
              );
            },
          )
        ];
      },
    );
  }
}
