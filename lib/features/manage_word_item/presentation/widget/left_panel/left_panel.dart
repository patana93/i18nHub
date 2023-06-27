import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_hub/features/context_top_menu/presentation/controller/current_file_controller.dart';
import 'package:i18n_hub/features/manage_word_item/presentation/widget/left_panel/node_list.dart';
import 'package:i18n_hub/features/manage_word_item/presentation/widget/left_panel/search_bar.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: SearchItemsBar(
              searchTextEditingController: textEditingController),
        ),
        Expanded(
          flex: 9,
          child: NodeList(textEditingController: textEditingController),
        ),
        const SizedBox(
          height: 30,
        ),
        Consumer(builder: (context, ref, child) {
          final currentFile = ref.watch(currentFileControllerProvider);
          return Text(
            currentFile == null
                ? "Project not saved yet"
                : "Current file: $currentFile.i18n",
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge,
          );
        }),
      ],
    );
  }
}
