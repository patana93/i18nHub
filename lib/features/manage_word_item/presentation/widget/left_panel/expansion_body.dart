import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/widget/left_panel/word_item_context_menu.dart';

class ExpansionBody extends ConsumerWidget {
//final ScrollController _scrollController = ScrollController();

  final TextEditingController textEditingController;
  final NodeModel nodeItem;
  const ExpansionBody(
      {required this.nodeItem, required this.textEditingController, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(selectionWordItemControllerProvider)?.key;
    return SizedBox(
      height: MediaQuery.of(context).size.height - 250,
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(height: 0),
        //controller: _scrollController,
        itemCount: nodeItem.wordItems.length,
        itemBuilder: (context, index) {
          final item = nodeItem.wordItems[index];
          return ListTile(
            selected: (selectedItem ?? "") == item.key,
            selectedTileColor: Colors.green,
            hoverColor: Colors.pink,
            tileColor: Colors.blue,
            selectedColor: Colors.amber,
            onTap: () {
              ref
                  .read(selectionWordItemControllerProvider.notifier)
                  .selectWordItem(nodeItem, item);
            },
            title: Text(item.key),
            trailing: WordItemContextMenu(
                nodeItem: nodeItem,
                item: item,
                textEditingController: textEditingController),
          );
        },
      ),
    );
  }
}
