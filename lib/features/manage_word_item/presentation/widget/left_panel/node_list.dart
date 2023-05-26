import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/widget/left_panel/expansion_body.dart';
import 'package:i18n_app/features/manage_word_item/presentation/widget/left_panel/expansion_header.dart';

class NodeList extends ConsumerWidget {
  final TextEditingController textEditingController;
  const NodeList({required this.textEditingController, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(manageWordItemControllerProvider);

    return Container(
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
                key: ValueKey(list),
                expansionCallback: (int index, bool exp) {
                  ref
                      .read(manageWordItemControllerProvider.notifier)
                      .setPanelExpansion(
                          textEditingController.text, list[index]);
                },
                children: [
                  ...list.map((nodeItem) => ExpansionPanel(
                      backgroundColor: Colors.white,
                      canTapOnHeader: true,
                      isExpanded: nodeItem.isPanelExpanded ?? false,
                      headerBuilder: (context, isExpanded) => ExpansionHeader(
                            nodeItem: nodeItem,
                            searchTextEditingController: textEditingController,
                          ),
                      body: ExpansionBody(
                        nodeItem: nodeItem,
                        textEditingController: textEditingController,
                      )))
                ]);
          },
        ),
      ),
    );
  }
}
