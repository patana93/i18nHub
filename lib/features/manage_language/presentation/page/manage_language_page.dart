import 'package:flutter/material.dart';
import 'package:i18n_app/features/manage_language/presentation/widget/add_language_action_chip.dart';
import 'package:i18n_app/features/manage_language/presentation/widget/language_selected_list.dart';

class ManageLanguagePage extends StatelessWidget {
  const ManageLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
        flex: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 10,
            ),
            Expanded(flex: 75, child: LanguageSelectedChipList()),
            Expanded(flex: 15, child: AddLanguageActionChip()),
          ],
        ));
  }
}
