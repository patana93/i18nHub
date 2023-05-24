import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/core/utils/const.dart';
import 'package:i18n_app/core/utils/shared_prefs.dart';
import 'package:i18n_app/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_app/features/new_project/presentation/widget/menu_entry.dart';
import 'package:path_provider/path_provider.dart';

MenuEntry getLoadMenu(WidgetRef ref) {
  return MenuEntry(
    label: "Load",
    onPressed: () async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          lockParentWindow: true,
          type: FileType.custom,
          allowedExtensions: ["i18n"]);
      List<File>? files;
      if (result != null) {
        files = result.paths.map((path) => File(path ?? "")).toList();
      } else {
        return;
      }

      await getApplicationDocumentsDirectory().then(
        (Directory directory) {
          final dir =
              SharedPrefs.getString(SharedPrefs.savePath) ?? directory.path;

          final jsonFile = File(
              "$dir${files?.first.path.substring(files.first.path.lastIndexOf("\\"))}");
          final fileExist = jsonFile.existsSync();
          if (fileExist) {
            final List<dynamic> fileContent =
                jsonDecode(jsonFile.readAsStringSync());
            final List<NodeModel> nodeItemList = [];

            for (var item in fileContent) {
              nodeItemList.add(NodeModel.fromJson(item));
            }

            ref.read(manageWordItemControllerProvider.notifier).clearAll();

            for (final node in nodeItemList) {
              ref
                  .read(manageWordItemControllerProvider.notifier)
                  .addNodeItem(node.nodeKey);
              for (final wordItem in node.wordItems) {
                ref
                    .read(manageWordItemControllerProvider.notifier)
                    .addWordItem(nodeItem: node, wordItem: wordItem);
              }
            }

            final languages = ref
                .read(manageWordItemControllerProvider)
                .map((e) => e.wordItems.map((e) => e.translations))
                .expand((element) => element)
                .toList()
                .expand((element) => element)
                .toList();
            ref.read(manageLanguageControllerProvider.notifier).clear();

            for (final lan in languages) {
              ref.read(manageLanguageControllerProvider.notifier).addLanguage(
                  selectedLanguage: Const.language.entries
                      .firstWhere((element) => element.key == lan.language));
            }
          }
        },
      );
    },
  );
}
