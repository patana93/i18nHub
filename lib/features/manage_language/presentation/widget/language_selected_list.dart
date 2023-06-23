import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_app/features/manage_language/presentation/widget/language_chip.dart';

class LanguageSelectedChipList extends ConsumerWidget {
  const LanguageSelectedChipList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageScrollController = ScrollController();
    return Scrollbar(
      controller: languageScrollController,
      child: ListView.builder(
        controller: languageScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: ref.watch(manageLanguageControllerProvider).length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: LanguageChip(
                isDefaultLanguage: index == 0,
                title: ref
                    .read(manageLanguageControllerProvider)
                    .elementAt(index)
                    .name),
          );
        },
      ),
    );
  }
}
