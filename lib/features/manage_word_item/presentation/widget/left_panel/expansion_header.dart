import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/core/utils/colors.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/widget/left_panel/add_edit_key_dialog.dart';
import 'package:i18n_app/features/manage_word_item/presentation/widget/left_panel/add_edit_node_dialog.dart';

class ExpansionHeader extends ConsumerWidget {
  final TextEditingController searchTextEditingController;
  final NodeModel nodeItem;
  const ExpansionHeader(
      {required this.nodeItem,
      required this.searchTextEditingController,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Visibility(
              visible: nodeItem.wordItems.any((element) =>
                  element.translations.any((element) => element.value.isEmpty)),
              child: const Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Color(0xFFE6C229),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              )),
          Text(nodeItem.nodeKey,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: I18nColor.blue)),
          const Spacer(),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddEditNodeDialog(
                        nodeItem: nodeItem,
                        searchString: searchTextEditingController.text);
                  },
                );
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Are you sure?"),
                    content: RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            const TextSpan(text: "You are deleting "),
                            TextSpan(
                                text: nodeItem.nodeKey,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const TextSpan(text: " node and all its elements"),
                          ]),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Cancel")),
                      ElevatedButton(
                          onPressed: () {
                            ref
                                .read(manageWordItemControllerProvider.notifier)
                                .removeNodeItem(nodeItem.nodeKey);
                            Navigator.of(context).pop();
                          },
                          child: const Text("Confirm")),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddEditKeyDialog(
                      //scrollController: _scrollController,
                      nodeItem: nodeItem,
                      searchString: searchTextEditingController.text,
                    );
                  },
                );
              },
              icon: const Icon(Icons.add)),
        ],
      ),
    );
  }
}
