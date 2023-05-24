import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/core/utils/shared_prefs.dart';
import 'package:i18n_app/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_app/features/new_project/presentation/widget/menu_entry.dart';

MenuEntry getSaveAsJsonMenu(WidgetRef ref) {
  return MenuEntry(
    label: 'Save as Json',
    onPressed: () {
      final nodeItems = ref.watch(manageWordItemControllerProvider);
      final langs = ref.watch(manageLanguageControllerProvider);

      final Map<String, String> result = {};

      for (var language in langs.entries) {
        for (var nodeItem in nodeItems) {
          for (var wordItem in nodeItem.wordItems) {
            final transitionModel = wordItem.translations
                .firstWhere((element) => element.language == language.key);
            result[wordItem.key] = transitionModel.value;
          }
        }

        final saveDir = SharedPrefs.getString(SharedPrefs.savePath);
        File file = File("$saveDir/${language.value}.json");
        file.createSync();
        file.writeAsStringSync(jsonEncode(result));
      }
    },
  );
}
