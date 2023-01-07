import 'package:flutter/material.dart';
import 'package:i18n_app/widgets/language_selected_list.dart';
import 'package:i18n_app/widgets/left_panel.dart';
import 'package:i18n_app/widgets/top_menu_button.dart';
import 'package:i18n_app/widgets/right_panel.dart';

import '../widgets/add_language_chip.dart';

class HomePage extends StatefulWidget {
  static const routeName = "translate-main-page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Align(
                alignment: Alignment.centerRight, child: TopMenuButton()),
            const SizedBox(
              height: 4,
            ),
            Expanded(
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
                        children: [
                          const Expanded(flex: 92, child: RightPanel()),
                          Expanded(
                              flex: 8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      flex: 75, child: LanguageSelectedList()),
                                  Expanded(flex: 15, child: AddLanguageChip()),
                                ],
                              )),
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
