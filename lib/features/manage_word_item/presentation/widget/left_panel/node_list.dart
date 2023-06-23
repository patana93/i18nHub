import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/core/utils/colors.dart';
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
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: I18nColor.blue)),
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(8),
                child: ExpansionTile(
                  onExpansionChanged: (value) {
                    ref
                        .read(manageWordItemControllerProvider.notifier)
                        .togglePanelExpansion(list[index]);
                  },
                  initiallyExpanded: list[index].isPanelExpanded ?? true,
                  title: ExpansionHeader(
                    nodeItem: list[index],
                    searchTextEditingController: textEditingController,
                  ),
                  children: [
                    ExpansionBody(
                      nodeItem: list[index],
                      textEditingController: textEditingController,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
