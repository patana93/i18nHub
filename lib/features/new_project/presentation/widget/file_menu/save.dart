import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/core/utils/shared_prefs.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_app/features/new_project/presentation/widget/menu_entry.dart';

//TODO add alert to choose the name file
MenuEntry getSaveMenu(WidgetRef ref) {
  return MenuEntry(
    label: 'Save',
    onPressed: () {
      String filename = "Myjson.i18n";

      final wordItems = ref.watch(manageWordItemControllerProvider);
      final saveDir = SharedPrefs.getString(SharedPrefs.savePath);
      File file = File("$saveDir/$filename");
      file.createSync();
      file.writeAsStringSync(jsonEncode(wordItems));
    },
  );
}
