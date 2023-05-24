import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/widget/add_key_dialog.dart';

class ExpansionHeader extends ConsumerWidget {
  final TextEditingController textEditingController;
  final NodeModel nodeItem;
  const ExpansionHeader(
      {required this.nodeItem, required this.textEditingController, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text(nodeItem.nodeKey),
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AddKeyDialog(
                    //scrollController: _scrollController,
                    nodeItem: nodeItem,
                    searchString: textEditingController.text,
                  );
                },
              );
            },
            icon: const Icon(Icons.add)),
        IconButton(
            onPressed: () {
              //TODO ADD ALERT TO CONFIRM
              ref
                  .read(manageWordItemControllerProvider.notifier)
                  .removeNodeItem(nodeItem.nodeKey);
            },
            icon: const Icon(Icons.remove)),
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  final controller =
                      TextEditingController(text: nodeItem.nodeKey);
                  return AlertDialog(
                    title: const Text("Edit Node"),
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
                                .read(manageWordItemControllerProvider.notifier)
                                .editNodeItem(
                                    nodeItem.nodeKey, controller.text);
                            Navigator.of(context).pop();
                          },
                          child: const Text("Save"))
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.edit)),
        Visibility(
            visible: nodeItem.wordItems.any((element) =>
                element.translations.any((element) => element.value.isEmpty)),
            child: const Icon(
              Icons.warning,
              color: Colors.amber,
            )),
      ],
    );
  }
}
