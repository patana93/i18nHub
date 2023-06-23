import 'package:flutter/material.dart';
import 'package:i18n_app/features/manage_language/presentation/widget/add_language_action_chip.dart';
import 'package:i18n_app/features/manage_language/presentation/widget/language_selected_list.dart';

class ManageLanguagePage extends StatelessWidget {
  const ManageLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(flex: 80, child: LanguageSelectedChipList()),
        Spacer(),
        Flexible(flex: 20, child: AddLanguageActionChip()),
      ],
    );
  }
}
