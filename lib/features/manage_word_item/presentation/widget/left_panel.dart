import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/search_focus_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/widget/add_key_dialog.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/translation_model.dart';
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
    List<bool> isExpanded = List.generate(list.length, (index) => false);

    return Column(
      children: [
        Flexible(
          child: Focus(
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            final controller = TextEditingController();
                            return AlertDialog(
                              title: const Text("Add Node"),
                              content: TextFormField(
                                controller: controller,
                                decoration: const InputDecoration(
                                    hintText: 'Enter the node',
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ))),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      ref
                                          .read(manageWordItemControllerProvider
                                              .notifier)
                                          .addNodeItem(controller.text);
                                    },
                                    child: const Text("Save"))
                              ],
                            );
                          },
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 9,
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
              ),
            ),
            child: SingleChildScrollView(
              child: StatefulBuilder(
                builder: (context, state) {
                  return ExpansionPanelList(
                      expansionCallback: (int index, bool exp) {
                        state(() {
                          isExpanded[index] = !isExpanded[index];
                        });
                      },
                      children: [
                        ...list.map((e) => ExpansionPanel(
                              backgroundColor: Colors.white,
                              canTapOnHeader: true,
                              isExpanded: isExpanded[list.indexOf(e)],
                              headerBuilder: (context, isExpanded) {
                                return Row(
                                  children: [
                                    Text(e.nodeKey),
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AddKeyDialog(
                                                //scrollController: _scrollController,
                                                nodeItem: e,
                                                searchString:
                                                    _textEditingController.text,
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.add))
                                  ],
                                );
                              },
                              body: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 250,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const Divider(height: 0),
                                  //controller: _scrollController,
                                  itemCount: e.wordItems.length,
                                  itemBuilder: (context, index) {
                                    final item = e.wordItems[index];
                                    return ListTile(
                                      selected:
                                          (selectedItem ?? "") == item.key,
                                      selectedTileColor: Colors.green,
                                      hoverColor: Colors.pink,
                                      tileColor: Colors.blue,
                                      selectedColor: Colors.amber,
                                      onTap: () {
                                        ref
                                            .read(
                                                selectionWordItemControllerProvider
                                                    .notifier)
                                            .selectWordItem(e, item);
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
                                                    .read(
                                                        manageWordItemControllerProvider
                                                            .notifier)
                                                    .removeWordItem(
                                                        nodeKey: e.nodeKey,
                                                        key: item.key,
                                                        searchString:
                                                            _textEditingController
                                                                .text);
                                                ref
                                                    .read(
                                                        selectionWordItemControllerProvider
                                                            .notifier)
                                                    .selectWordItem(e, null);
                                              },
                                            ),
                                            PopupMenuItem(
                                              child: const Text("Rename"),
                                              onTap: () async {
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 200));
                                                // ignore: use_build_context_synchronously
                                                await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AddKeyDialog(
                                                      //scrollController: _scrollController,
                                                      nodeItem: e,
                                                      wordItemEdit: item,
                                                      searchString:
                                                          _textEditingController
                                                              .text,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            PopupMenuItem(
                                              child:
                                                  const Text("Duplicate key"),
                                              onTap: () {
                                                WordItem duplicate = item;
                                                String copyKey = duplicate.key;
                                                Set<TranslationModel>
                                                    newTranslations = {};

                                                for (final newTranslation
                                                    in item.translations) {
                                                  newTranslations.add(
                                                      newTranslation.copyWith(
                                                          value: "",
                                                          isEqualToDefault:
                                                              false));
                                                }

                                                while (ref
                                                    .read(
                                                        manageWordItemControllerProvider
                                                            .notifier)
                                                    .checkWordItemKeyAlreadyExist(
                                                        key: copyKey)) {
                                                  copyKey += "_copy";
                                                }

                                                ref
                                                    .read(
                                                        manageWordItemControllerProvider
                                                            .notifier)
                                                    .addWordItem(
                                                      nodeItem: e,
                                                      wordItem: (
                                                        key: copyKey,
                                                        translations:
                                                            newTranslations,
                                                      ),
                                                      searchString:
                                                          _textEditingController
                                                              .text,
                                                    );
                                              },
                                            ),
                                            PopupMenuItem(
                                              child:
                                                  const Text("Duplicate all"),
                                              onTap: () {
                                                String duplicate = item.key;
                                                while (ref
                                                    .read(
                                                        manageWordItemControllerProvider
                                                            .notifier)
                                                    .checkWordItemKeyAlreadyExist(
                                                        key: duplicate)) {
                                                  duplicate += "_copy";
                                                }

                                                ref
                                                    .read(
                                                        manageWordItemControllerProvider
                                                            .notifier)
                                                    .addWordItem(
                                                        nodeItem: e,
                                                        wordItem: (
                                                          key: duplicate,
                                                          translations:
                                                              item.translations,
                                                        ),
                                                        searchString:
                                                            _textEditingController
                                                                .text);
                                              },
                                            )
                                          ];
                                        },
                                      ),
                                      title: Text(item.key),
                                    );
                                  },
                                ),
                              ),
                            ))
                      ]);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
