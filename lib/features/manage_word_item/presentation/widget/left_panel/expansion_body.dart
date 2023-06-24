import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_hub/core/utils/colors.dart';
import 'package:i18n_hub/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_hub/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';
import 'package:i18n_hub/features/manage_word_item/presentation/widget/left_panel/word_item_context_menu.dart';

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
      height: nodeItem.wordItems.length * 50,
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(height: 0),
        //controller: _scrollController,
        itemCount: nodeItem.wordItems.length,
        itemBuilder: (context, index) {
          final item = nodeItem.wordItems[index];
          return ListTile(
            selected: (selectedItem ?? "") == item.key,
            selectedTileColor: I18nColor.blue,
            splashColor: I18nColor.blue,
            tileColor: Colors.white,
            selectedColor: Colors.white,
            onTap: () {
              ref
                  .read(selectionWordItemControllerProvider.notifier)
                  .selectWordItem(nodeItem, item);
            },
            title: Text(item.key),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                      visible: item.translations
                          .any((element) => element.value.isEmpty),
                      child: const Icon(
                        Icons.warning,
                        color: I18nColor.alert,
                      )),
                  WordItemContextMenu(
                    nodeItem: nodeItem,
                    item: item,
                    textEditingController: textEditingController,
                    isSelectedItem: (selectedItem ?? "") == item.key,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
