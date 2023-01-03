// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:i18n_app/widgets/language_selected_list.dart';
import 'package:i18n_app/widgets/left_panel.dart';
import 'package:i18n_app/widgets/right_panel.dart';

import '../widgets/add_language_chip.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Expanded(
                                flex: 75, child: LanguageSelectedList()),
                            const Expanded(flex: 15, child: AddLanguageChip()),
                          ],
                        )),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
