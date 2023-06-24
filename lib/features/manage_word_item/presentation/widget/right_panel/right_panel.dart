import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_hub/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';
import 'package:i18n_hub/features/manage_word_item/presentation/widget/right_panel/no_selected_item.dart';
import 'package:i18n_hub/features/manage_word_item/presentation/widget/right_panel/translation_list.dart';

class RightPanel extends ConsumerWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(selectionWordItemControllerProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(28),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          width: 1,
          style: BorderStyle.solid,
          color: Colors.black.withAlpha(125),
        ),
      ),
      child: selectedItem == null
          ? const NoSelectedItem()
          : TranslationList(selectedItem: selectedItem),
    );
  }
}
