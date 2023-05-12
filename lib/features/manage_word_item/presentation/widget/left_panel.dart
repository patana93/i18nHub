import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/search_focus_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/widget/add_key_dialog.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/word_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';

final TextEditingController _textEditingController = TextEditingController();

final FocusNode _focus = FocusNode();

//final ScrollController _scrollController = ScrollController();
class LeftPanel extends ConsumerWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(manageWordItemControllerProvider);
    final selectedItem = ref.watch(selectionWordItemControllerProvider)?.key;

    return Column(
      children: [
        Focus(
          onFocusChange: (isFocus) => ref
              .read(searchFocusControllerProvider.notifier)
              .setFocusColor(isFocus),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              border: ref.watch(searchFocusControllerProvider)
                  ? Border.all(color: Colors.blue, width: 2)
                  : Border.all(color: Colors.grey, width: 1),
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 10,
                  child: TextField(
                    focusNode: _focus,
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.zero),
                    ),
                    onChanged: (value) {
                      ref
                          .read(manageWordItemControllerProvider.notifier)
                          .filterData(value);
                    },
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AddKeyDialog(
                            //scrollController: _scrollController,
                            searchString: _textEditingController.text,
                          );
                        },
                      );
                    }),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 90,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                border: Border.all(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.grey.withAlpha(128),
                )),
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(height: 0),
              //controller: _scrollController,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  selected: (selectedItem ?? "") == list[index].key,
                  selectedTileColor: Colors.green,
                  hoverColor: Colors.pink,
                  tileColor: Colors.blue,
                  selectedColor: Colors.amber,
                  onTap: () {
                    ref
                        .read(selectionWordItemControllerProvider.notifier)
                        .selectWordItem(list[index]);
                  },
                  trailing: PopupMenuButton(
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
                                    key: list[index].key,
                                    searchString: _textEditingController.text);
                            ref
                                .read(selectionWordItemControllerProvider
                                    .notifier)
                                .selectWordItem(null);
                          },
                        ),
                        PopupMenuItem(
                          child: const Text("Rename"),
                          onTap: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 200));
                            // ignore: use_build_context_synchronously
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AddKeyDialog(
                                  //scrollController: _scrollController,
                                  wordItemEdit: list[index],
                                  searchString: _textEditingController.text,
                                );
                              },
                            );
                          },
                        ),
                        PopupMenuItem(
                          child: const Text("Duplicate key"),
                          onTap: () {
                            WordModel duplicate = list[index];
                            String copyKey = duplicate.key;
                            Set<TranslationModel> newTranslations = {};

                            for (final newTranslation
                                in list[index].translations) {
                              newTranslations.add(newTranslation.copyWith(
                                  value: "", isEqualToDefault: false));
                            }

                            while (ref
                                .read(manageWordItemControllerProvider.notifier)
                                .checkWordItemKeyAlreadyExist(key: copyKey)) {
                              copyKey += "_copy";
                            }

                            ref
                                .read(manageWordItemControllerProvider.notifier)
                                .addWordItem(
                                  wordItem: WordModel(
                                    key: copyKey,
                                    translations: newTranslations,
                                  ),
                                  searchString: _textEditingController.text,
                                );
                          },
                        ),
                        PopupMenuItem(
                          child: const Text("Duplicate all"),
                          onTap: () {
                            String duplicate = list[index].key;
                            while (ref
                                .read(manageWordItemControllerProvider.notifier)
                                .checkWordItemKeyAlreadyExist(key: duplicate)) {
                              duplicate += "_copy";
                            }

                            ref
                                .read(manageWordItemControllerProvider.notifier)
                                .addWordItem(
                                    wordItem: WordModel(
                                      key: duplicate,
                                      translations: list[index].translations,
                                    ),
                                    searchString: _textEditingController.text);
                          },
                        )
                      ];
                    },
                  ),
                  title: Text(list[index].key),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
