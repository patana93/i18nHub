import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../utils/const.dart';
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
                                              selectionWorditemControllerProvider
                                                  .notifier)
                                          .selectWordItem(null);
                                      ref
                                          .read(manageLanguageControllerProvider
                                              .notifier)
                                          .resetToDefault(
                                              defaultLanguage: Const.language
                                                  .elementAt(index));
                                      ref
                                          .read(makeNewProjectControllerProvider
                                              .notifier)
                                          .makeNewProject(
                                              selectedLanguage: Const.language
                                                  .elementAt(index));

                                      Navigator.of(context).pop();
                                    },
                                    title:
                                        Text(Const.language.elementAt(index)));
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
            onPressed: () async {
              Directory? dir;
              String filename = "Myjson.json";
              await getApplicationDocumentsDirectory()
                  .then((Directory directory) {
                dir = directory;

                print(dir);
                /*final jsonFile = File("${dir?.path}/$filename");
                    fileExist = jsonFile.existsSync();
                  print(fileExist);
                  if (fileExist) {
                    print("Exist");
                    fileContent = jsonDecode(jsonFile.readAsStringSync()); 
                  } */
                final wordItems = ref.watch(manageWordItemControllerProvider);

                File file = File("${dir!.path}/$filename");
                file.createSync();
                file.writeAsStringSync(jsonEncode(wordItems.first.toJson()));
                /*final wordItems = ref.watch(wordItemNotifierProvider); */
              });
            },
          )
        ],
      )
    ];
    return result;
  }
}
