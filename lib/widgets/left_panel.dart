import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/widgets/add_key_dialog.dart';
import '../models/text_cursor_position.dart';
import '../models/word_item.dart';

final TextEditingController _textEditingController = TextEditingController();

final FocusNode _focus = FocusNode();
final ScrollController _scrollController = ScrollController();
Color _highlightContainerColor = Colors.grey;

class LeftPanel extends ConsumerWidget {
  const LeftPanel({super.key});

  void _onFocusChange(StateSetter containerState) {
    containerState(
      () {
        if (_focus.hasFocus) {
          _highlightContainerColor = Colors.blue;
        } else {
          _highlightContainerColor = Colors.grey;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(wordItemFilteredNotifierProvider);

    return Column(
      children: [
        StatefulBuilder(builder: (context, containerState) {
          _focus.addListener(() => _onFocusChange(containerState));
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              border: Border.all(color: _highlightContainerColor),
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
                          .read(wordItemFilteredNotifierProvider.notifier)
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
                            scrollController: _scrollController,
                          );
                        },
                      );
                    }),
              ],
            ),
          );
        }),
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
              controller: _scrollController,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  selected: (ref.watch(wordItemSelectedNotifierProvider)?.key ??
                          "") ==
                      list[index].key,
                  selectedTileColor: Colors.green,
                  hoverColor: Colors.pink,
                  tileColor: Colors.blue,
                  selectedColor: Colors.amber,
                  onTap: () {
                    ref
                        .read(wordItemSelectedNotifierProvider.notifier)
                        .selectWordItem(list[index].key);
                    ref
                        .read(textCursorPositionNotifierProvider.notifier)
                        .setTextCursorPosition(0);
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
                                .read(wordNotifierProvider.notifier)
                                .removeWord(list[index].key);
                          },
                        ),
                        PopupMenuItem(
                          child: const Text("Rename"),
                          onTap: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 200));
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AddKeyDialog(
                                  scrollController: _scrollController,
                                  wordItemEdit: list[index],
                                );
                              },
                            );
                          },
                        ),
                        PopupMenuItem(
                          child: const Text("Duplicate key"),
                          onTap: () {
                            String duplicate = list[index].key;
                            while (ref
                                .read(wordNotifierProvider.notifier)
                                .checkKeyAlreadyExist(duplicate)) {
                              duplicate += "_copy";
                            }

                            ref.read(wordNotifierProvider.notifier).addWord(
                                  WordModel(
                                    key: duplicate,
                                    translations: const [],
                                  ),
                                );
                          },
                        ),
                        PopupMenuItem(
                          child: const Text("Duplicate all"),
                          onTap: () {
                            String duplicate = list[index].key;
                            while (ref
                                .read(wordNotifierProvider.notifier)
                                .checkKeyAlreadyExist(duplicate)) {
                              duplicate += "_copy";
                            }

                            ref.read(wordNotifierProvider.notifier).addWord(
                                  WordModel(
                                    key: duplicate,
                                    translations: list[index].translations,
                                  ),
                                );
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
