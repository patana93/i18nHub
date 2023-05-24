import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/search_focus_controller.dart';

class SearchItemsBar extends ConsumerWidget {
  final TextEditingController textEditingController;
  const SearchItemsBar({required this.textEditingController, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FocusNode focus = FocusNode();

    return Focus(
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
                focusNode: focus,
                controller: textEditingController,
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
                                Navigator.of(context).pop();
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
    );
  }
}
