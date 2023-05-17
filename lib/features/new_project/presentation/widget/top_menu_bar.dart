import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/core/utils/shared_prefs.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/word_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/utils/const.dart';
import '../../../manage_language/presentation/controller/manage_language_controller.dart';
import '../controller/new_project_controller.dart';

class MenuEntry {
  const MenuEntry(
      {required this.label, this.shortcut, this.onPressed, this.menuChildren})
      : assert(menuChildren == null || onPressed == null,
            'onPressed is ignored if menuChildren are provided');
  final String label;

  final MenuSerializableShortcut? shortcut;
  final VoidCallback? onPressed;
  final List<MenuEntry>? menuChildren;

  static List<Widget> build(List<MenuEntry> selections) {
    Widget buildSelection(MenuEntry selection) {
      if (selection.menuChildren != null) {
        return SubmenuButton(
          menuChildren: MenuEntry.build(selection.menuChildren!),
          child: Text(selection.label),
        );
      }
      return MenuItemButton(
        shortcut: selection.shortcut,
        onPressed: selection.onPressed,
        child: Text(selection.label),
      );
    }

    return selections.map<Widget>(buildSelection).toList();
  }

  static Map<MenuSerializableShortcut, Intent> shortcuts(
      List<MenuEntry> selections) {
    final Map<MenuSerializableShortcut, Intent> result =
        <MenuSerializableShortcut, Intent>{};
    for (final MenuEntry selection in selections) {
      if (selection.menuChildren != null) {
        result.addAll(MenuEntry.shortcuts(selection.menuChildren!));
      } else {
        if (selection.shortcut != null && selection.onPressed != null) {
          result[selection.shortcut!] =
              VoidCallbackIntent(selection.onPressed!);
        }
      }
    }
    return result;
  }
}

class TopMenuBar extends ConsumerWidget {
  const TopMenuBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: MenuBar(
                children: MenuEntry.build(_getMenus(context, ref)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<MenuEntry> _getMenus(BuildContext context, WidgetRef ref) {
    final savePathController = TextEditingController(
        text: SharedPrefs.getString(SharedPrefs.savePath));
    final List<MenuEntry> result = <MenuEntry>[
      MenuEntry(
        label: 'File',
        menuChildren: <MenuEntry>[
          MenuEntry(
            label: 'New Project',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: 300,
                          maxWidth:
                              MediaQuery.of(context).size.width / 4 + 300),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Selecte Default Language",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Text(
                            "You cannot change this after",
                            style: TextStyle(fontSize: 16),
                          ),
                          /*     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        //  focusNode: _focus,
                        //  controller: _textEditingController,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                        ),
                        onChanged: (value) {
                          // ref
                          //     .read(wordItemFilteredNotifierProvider.notifier)
                          //   .filterData(value);
                        },
                      ),
                    ), */
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: Const.language.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    onTap: () {
                                      ref
                                          .read(
                                              selectionWordItemControllerProvider
                                                  .notifier)
                                          .selectWordItem(null);
                                      ref
                                          .read(manageLanguageControllerProvider
                                              .notifier)
                                          .resetToDefault(
                                              defaultLanguage: Const
                                                  .language.entries
                                                  .elementAt(index));
                                      ref
                                          .read(makeNewProjectControllerProvider
                                              .notifier)
                                          .makeNewProject(
                                              selectedLanguage: Const
                                                  .language.keys
                                                  .elementAt(index));

                                      Navigator.of(context).pop();
                                    },
                                    title: Text(
                                        Const.language.keys.elementAt(index)));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          MenuEntry(
            label: 'Save',
            onPressed: () {
              String filename = "Myjson.i18n";

              final wordItems = ref.watch(manageWordItemControllerProvider);
              final saveDir = SharedPrefs.getString(SharedPrefs.savePath);
              File file = File("$saveDir/$filename");
              file.createSync();
              file.writeAsStringSync(jsonEncode(wordItems));
            },
          ),
          MenuEntry(
            label: 'Save as Json',
            onPressed: () {
              final wordItems = ref.watch(manageWordItemControllerProvider);
              final langs = ref.watch(manageLanguageControllerProvider);

              final Map<String, String> result = {};

              for (var language in langs.entries) {
                for (var wordItem in wordItems) {
                  final transitionModel = wordItem.translations.firstWhere(
                      (element) => element.language == language.key);
                  result[wordItem.key] = transitionModel.value;
                }
                final saveDir = SharedPrefs.getString(SharedPrefs.savePath);
                File file = File("$saveDir/${language.value}.json");
                file.createSync();
                file.writeAsStringSync(jsonEncode(result));
              }
            },
          ),
          MenuEntry(
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
                // User canceled the picker
              }

              await getApplicationDocumentsDirectory().then(
                (Directory directory) {
                  final jsonFile = File(
                      "${directory.path}${files?.first.path.substring(files.first.path.lastIndexOf("\\"))}");
                  final fileExist = jsonFile.existsSync();
                  if (fileExist) {
                    final List<dynamic> fileContent =
                        jsonDecode(jsonFile.readAsStringSync());
                    final List<WordModel> wordItemList = [];
                    for (var item in fileContent) {
                      wordItemList.add(WordModel.fromJson(item));
                    }

                    ref
                        .read(manageWordItemControllerProvider.notifier)
                        .clearAll();
                    for (final word in wordItemList) {
                      ref
                          .read(manageWordItemControllerProvider.notifier)
                          .addWordItem(wordItem: word);
                    }

                    final languages = ref
                        .read(manageWordItemControllerProvider)
                        .map((e) => e.translations)
                        .expand((element) => element)
                        .toList();

                    ref.read(manageLanguageControllerProvider.notifier).clear();

                    for (final lan in languages) {
                      ref
                          .read(manageLanguageControllerProvider.notifier)
                          .addLanguage(
                              selectedLanguage: Const.language.entries
                                  .firstWhere((element) =>
                                      element.key == lan.language));
                    }
                  }
                },
              );
            },
          )
        ],
      ),
      MenuEntry(label: 'Settings', menuChildren: <MenuEntry>[
        MenuEntry(
            label: "Select Save Folder",
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Select Directory"),
                  content: Row(
                    children: [
                      SizedBox(
                          width: 250,
                          child: TextField(
                            readOnly: true,
                            controller: savePathController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          )),
                      const SizedBox(
                        width: 12,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            final a =
                                await FilePicker.platform.getDirectoryPath(
                              dialogTitle: 'Save Your File to desired location',
                            );
                            if (a != null) {
                              SharedPrefs.setString(SharedPrefs.savePath, a);
                            }

                            savePathController.text =
                                a ?? savePathController.text;

                            print(a);
                          },
                          child: const Text("Choose dir..."))
                    ],
                  ),
                ),
              );
            })
      ]),
    ];
    return result;
  }
}
