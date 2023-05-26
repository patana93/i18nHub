import 'package:flutter/material.dart';
import 'package:i18n_app/features/manage_word_item/presentation/widget/left_panel/node_list.dart';
import 'package:i18n_app/features/manage_word_item/presentation/widget/left_panel/search_bar.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();

    return Column(
      children: [
        Flexible(
          child: SearchItemsBar(
              searchTextEditingController: textEditingController),
        ),
        Expanded(
          flex: 9,
          child: NodeList(textEditingController: textEditingController),
        ),
      ],
    );
  }
}
