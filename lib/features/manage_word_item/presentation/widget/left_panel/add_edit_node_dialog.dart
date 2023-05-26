import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/validate_key_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';

class AddEditNodeDialog extends StatelessWidget {
  final NodeModel? nodeItem;
  // final ScrollController scrollController;
  final String searchString;
  const AddEditNodeDialog(
      {
      //required this.scrollController,
      required this.nodeItem,
      required this.searchString,
      super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController keyEditingController = TextEditingController();
    if (nodeItem != null) {
      keyEditingController.text = nodeItem!.nodeKey;
    }

    return AlertDialog(
      title: Text(nodeItem == null ? "Add node" : "Edit node"),
      content: Consumer(builder: (context, ref, child) {
        String? errorMessage = "";
        ref.listen(validateKeyControllerProvider, (previous, next) {
          errorMessage = next;
        });

        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return errorMessage;
          },
          onChanged: (value) {
            ref.read(validateKeyControllerProvider.notifier).validate(value);
          },
          controller: keyEditingController,
          decoration: const InputDecoration(
            errorMaxLines: 2,
            hintText: 'Enter the node name',
            hintStyle: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
        );
      }),
      actions: [
        Consumer(
          builder: (context, ref, child) => TextButton(
              onPressed: ref.watch(validateKeyControllerProvider) != null
                  ? null
                  : () {
                      if (nodeItem == null) {
                        ref
                            .read(manageWordItemControllerProvider.notifier)
                            .addNodeItem(keyEditingController.text);
                      } else {
                        ref
                            .read(manageWordItemControllerProvider.notifier)
                            .editNodeItem(
                                nodeKey: nodeItem!.nodeKey,
                                newNodeKey: keyEditingController.text,
                                isExpanded: nodeItem!.isPanelExpanded);
                      }

                      Navigator.of(context).pop();
                      //  await Scrollable.ensureVisible(context);

                      //  scrollController
                      //      .animateTo(
                      //    scrollController.position.maxScrollExtent + 50,
                      //    duration: const Duration(milliseconds: 300),
                      //    curve: Curves.easeOut,
                      //  )
                      //      .whenComplete(() {
                      //});
                    },
              child: const Text("Save")),
        )
      ],
    );
  }
}
