import 'package:flutter/material.dart';
import 'package:i18n_app/features/manage_language/presentation/page/manage_language_page.dart';
import 'package:i18n_app/features/manage_word_item/presentation/widget/left_panel.dart';
import 'package:i18n_app/features/manage_word_item/presentation/widget/right_panel.dart';

class ManageWordItemPage extends StatelessWidget {
  const ManageWordItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(flex: 3, child: LeftPanel()),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              flex: 7,
              child: Column(
                children: const [
                  Expanded(flex: 92, child: RightPanel()),
                  ManageLanguagePage()
                ],
              ))
        ],
      ),
    );
  }
}
