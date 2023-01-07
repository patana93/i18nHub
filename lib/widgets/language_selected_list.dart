import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/models/language_selected.dart';
import 'package:i18n_app/widgets/default_language_chip.dart';
import 'package:i18n_app/widgets/language_chip.dart';

class LanguageSelectedList extends ConsumerWidget {
  const LanguageSelectedList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageScrollController = ScrollController();
    return Scrollbar(
      controller: languageScrollController,
      child: ListView.builder(
        controller: languageScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: ref.watch(languageSelectedNotifierProvider).length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: index == 0
                ? DefaultLanguageChip(
                    title: ref
                        .read(languageSelectedNotifierProvider)
                        .elementAt(index))
                : LanguageChip(
                    title: ref
                        .read(languageSelectedNotifierProvider)
                        .elementAt(index)),
          );
        },
      ),
    );
  }
}
