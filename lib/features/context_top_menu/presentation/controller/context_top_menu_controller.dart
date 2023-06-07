import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:i18n_app/core/utils/const.dart';
import 'package:i18n_app/core/utils/languages_enum.dart';
import 'package:i18n_app/core/utils/shared_prefs.dart';
import 'package:i18n_app/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'context_top_menu_controller.g.dart';

@riverpod
class ContextTopMenuController extends _$ContextTopMenuController {
  @override
  void build() {}

  void makeNewProject({required String selectedLanguage}) async {
    ref.read(manageWordItemControllerProvider.notifier).clearAll();
    ref
        .read(manageWordItemControllerProvider.notifier)
        .addTranslationLanguages(newLanguage: selectedLanguage);
    ref
        .read(manageWordItemControllerProvider.notifier)
        .addNodeItem(mainNodeName);
  }

  void saveProject(String fileName) {
    String filename = "$fileName.i18n";

    final wordItems = ref.watch(manageWordItemControllerProvider);
    final saveDir = SharedPrefs.getString(SharedPrefs.savePath);
    File file = File("$saveDir/$filename");
    file.createSync();
    file.writeAsStringSync(jsonEncode(wordItems));
  }

  void saveJsonLanguages({required bool isWithNodes}) {
    final nodeItems = ref.watch(manageWordItemControllerProvider);
    final langs = ref.watch(manageLanguageControllerProvider);

    final Map<String, dynamic> result = {};

    for (var language in langs) {
      if (isWithNodes) {
        for (var nodeItem in nodeItems) {
          for (var wordItem in nodeItem.wordItems) {
            final transitionModel = wordItem.translations
                .firstWhere((element) => element.languageName == language.name);
            if (result[nodeItem.nodeKey] == null) {
              result[nodeItem.nodeKey] = {wordItem.key: transitionModel.value};
            } else {
              (result[nodeItem.nodeKey] as Map<String, String>)
                  .addAll({wordItem.key: transitionModel.value});
            }
          }
        }
      } else {
        for (var nodeItem in nodeItems) {
          for (var wordItem in nodeItem.wordItems) {
            final transitionModel = wordItem.translations
                .firstWhere((element) => element.languageName == language.name);
            result[wordItem.key] = transitionModel.value;
          }
        }
      }

      final saveDir = SharedPrefs.getString(SharedPrefs.savePath);
      File file = File("$saveDir/${language.code}.json");
      file.createSync();
      file.writeAsStringSync(jsonEncode(result));
    }
  }

  void loadProject() async {
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

          final aa = ref.read(manageWordItemControllerProvider);
          for (var i in aa) {
            print("aaaaaaaaaaaa: ${i.wordItems}");
          }

          final languages = ref
              .read(manageWordItemControllerProvider)
              .map((e) => e.wordItems.map((e) => e.translations))
              .expand((element) => element)
              .toSet()
              .expand((element) => element.map((e) => e.languageName))
              .toSet();

          ref.read(manageLanguageControllerProvider.notifier).clear();

          for (final lan in languages) {
            final selectedLan = LanguagesAvailable.values
                .firstWhere((element) => element.name == lan);
            ref.read(manageLanguageControllerProvider.notifier).addLanguage(
                selectedLanguage: (
                  code: selectedLan.code,
                  name: selectedLan.name
                ),
                isAddTranslationLanguagesRequired: false);
          }
        }
      },
    );
  }
}
