import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/word_item.dart';

final TextEditingController _textEditingController = TextEditingController();
final TextEditingController _textEditingController2 = TextEditingController();
final ScrollController _scrollController = ScrollController();

class LeftPanel extends ConsumerWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(wordItemFilteredNotifierProvider);
    return Column(
      children: [
        Expanded(
          flex: 10,
          child: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ))),
            onChanged: (value) {
              ref
                  .read(wordItemFilteredNotifierProvider.notifier)
                  .filterData(value);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  ref.read(wordItemNotifierProvider.notifier).addWord(WordItem(
                      key: _textEditingController2.text,
                      translations: const {}));

                  await Scrollable.ensureVisible(context);

                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent + 50,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                child: const Text("add")),
            Flexible(
              child: TextField(
                controller: _textEditingController2,
                decoration: const InputDecoration(
                    hintText: 'Add',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                    ))),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  ref.read(wordItemNotifierProvider.notifier).clearAll();
                },
                child: const Text("clear")),
          ],
        ),
        Expanded(
          flex: 90,
          child: Container(
            padding: const EdgeInsets.only(top: 4),
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
              separatorBuilder: (context, index) => const Divider(),
              controller: _scrollController,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onSecondaryTap: () {
                    ref
                        .read(wordItemNotifierProvider.notifier)
                        .removeWord(list[index].key);
                  },
                  child: ListTile(
                    trailing: PopupMenuButton(
                      splashRadius: 24,
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            child: Text("asd"),
                          )
                        ];
                      },
                    ),
                    title: Text(list[index].key),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
