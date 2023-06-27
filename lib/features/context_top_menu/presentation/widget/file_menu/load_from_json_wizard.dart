import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_hub/core/utils/colors.dart';
import 'package:i18n_hub/core/utils/const.dart';
import 'package:i18n_hub/core/utils/languages_enum.dart';
import 'package:i18n_hub/features/context_top_menu/presentation/controller/context_top_menu_controller.dart';
import 'package:i18n_hub/features/context_top_menu/presentation/controller/current_file_controller.dart';
import 'package:i18n_hub/features/context_top_menu/presentation/controller/load_from_json_controller.dart';
import 'package:i18n_hub/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_hub/features/manage_word_item/domain/model/node_model.dart';
import 'package:i18n_hub/features/manage_word_item/domain/model/translation_model.dart';
import 'package:i18n_hub/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_hub/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';
import 'package:path_provider/path_provider.dart';

class LoadFromJsonWizard extends ConsumerStatefulWidget {
  const LoadFromJsonWizard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoadFromJsonWizardState();
}

//TODO Change with external windows once Flutter deploy the feature
class _LoadFromJsonWizardState extends ConsumerState<LoadFromJsonWizard> {
  @override
  Widget build(BuildContext context) {
    final languages = ref.watch(loadFromJsonControllerProvider);
    return AlertDialog(
      title: const Text("Load form Json wizard"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
              "With this wizard you can load you JSON file named with country code (ex: en.json or en-us.json). The region will be not detected. Load files with nodes is not supported yet"),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("File list"),
              ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            lockParentWindow: true,
                            type: FileType.custom,
                            allowedExtensions: ["json"]);
                    List<File>? files;
                    if (result != null) {
                      files =
                          result.paths.map((path) => File(path ?? "")).toList();
                    } else {
                      return;
                    }

                    ref
                        .read(loadFromJsonControllerProvider.notifier)
                        .loadLanguage(files.first.path);
                    setState(() {});
                  },
                  child: const Text("Add JSON")),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: SizedBox(
              width: 400,
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) => ListTile(
                    tileColor: LanguagesAvailable.getLanguageName(
                              languages[index].substring(
                                languages[index].lastIndexOf("\\") + 1,
                                languages[index].lastIndexOf("."),
                              ),
                            ) ==
                            "Invalid code"
                        ? I18nColor.alert
                        : Colors.white,
                    title: Text(languages[index]),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: I18nColor.blue,
                      ),
                      onPressed: () => setState(() {
                        ref
                            .read(loadFromJsonControllerProvider.notifier)
                            .removeLanguage(languages[index]);
                      }),
                    ),
                    subtitle: RichText(
                      text: TextSpan(
                        text: "Language detected: ",
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: LanguagesAvailable.getLanguageName(
                              languages[index].substring(
                                languages[index].lastIndexOf("\\") + 1,
                                languages[index].lastIndexOf("."),
                              ),
                            ),
                          ),
                          index == 0
                              ? const TextSpan(
                                  text: "\nMain Language",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              : const TextSpan(),
                        ],
                      ),
                    )),
              ),
            ),
          )
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          //TODO Clean this code
          onPressed: () async {
            final languagesAvailable =
                LanguagesAvailable.values.firstWhere((element) =>
                    element.name ==
                    LanguagesAvailable.getLanguageName(
                      languages.first.substring(
                        languages.first.lastIndexOf("\\") + 1,
                        languages.first.lastIndexOf("."),
                      ),
                    ));

            ref
                .read(selectionWordItemControllerProvider.notifier)
                .selectWordItem(null, null);
            ref.read(manageLanguageControllerProvider.notifier).resetToDefault(
                defaultLanguage: (
                  code: languagesAvailable.code,
                  name: languagesAvailable.name
                ));
            ref.read(contextTopMenuControllerProvider.notifier).makeNewProject(
                    selectedLanguage: LanguagesAvailable.getLanguageName(
                  languages.first.substring(
                    languages.first.lastIndexOf("\\") + 1,
                    languages.first.lastIndexOf("."),
                  ),
                ));

            ref.read(manageWordItemControllerProvider.notifier).clearAll();
            ref.read(manageLanguageControllerProvider.notifier).clear();
            final List<NodeModel> nodeItemList = [];
            for (var lil in languages) {
              final bb = LanguagesAvailable.values.firstWhereOrNull((element) =>
                  element.name ==
                  LanguagesAvailable.getLanguageName(
                    lil.substring(
                      languages.first.lastIndexOf("\\") + 1,
                      languages.first.lastIndexOf("."),
                    ),
                  ));

              if (bb == null) {
                return;
              }

              await getApplicationDocumentsDirectory().then(
                (Directory directory) {
                  final dir = lil;

                  final jsonFile = File(dir);
                  final fileExist = jsonFile.existsSync();
                  if (fileExist) {
                    final Map<String, dynamic> fileContent =
                        jsonDecode(jsonFile.readAsStringSync());

                    nodeItemList
                        .add(NodeModel(nodeKey: mainNodeName, wordItems: [
                      for (var item in fileContent.entries)
                        (
                          key: item.key,
                          translations: {
                            TranslationModel(
                                languageName:
                                    LanguagesAvailable.getLanguageName(
                                  lil.substring(
                                    lil.lastIndexOf("\\") + 1,
                                    lil.lastIndexOf("."),
                                  ),
                                ),
                                value: item.value)
                          }
                        )
                    ]));
                  }
                },
              );
            }

            ref
                .read(manageWordItemControllerProvider.notifier)
                .addNodeItem(mainNodeName);
            final Set<String> alreadyWordItemKey = {};
            final Set<String> alreadyLang = {};
            for (final nodeItem in nodeItemList) {
              for (final wordItem in nodeItem.wordItems) {
                if (!alreadyLang
                    .contains(wordItem.translations.first.languageName)) {
                  ref
                      .read(manageLanguageControllerProvider.notifier)
                      .addLanguage(selectedLanguage: (
                    code: LanguagesAvailable.getLanguageCode(
                        wordItem.translations.first.languageName),
                    name: wordItem.translations.first.languageName
                  ));
                }

                alreadyLang.add(wordItem.translations.first.languageName);

                if (!alreadyWordItemKey.contains(wordItem.key)) {
                  ref
                      .read(manageWordItemControllerProvider.notifier)
                      .addWordItem(nodeItem: nodeItem, wordItem: wordItem);
                } else {
                  for (final translation in wordItem.translations) {
                    ref
                        .read(manageWordItemControllerProvider.notifier)
                        .editWordTranslation(
                            nodeItem: nodeItem,
                            key: wordItem.key,
                            newTranslation: translation);
                  }
                }
                alreadyWordItemKey.add(wordItem.key);
              }

              ref.read(currentFileControllerProvider.notifier).removeLanguage();
            }
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: const Text("Load"),
        )
      ],
    );
  }
}
