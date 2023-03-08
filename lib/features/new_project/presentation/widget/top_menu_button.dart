import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_app/features/manage_word_item/domain/model/word_model.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:i18n_app/features/new_project/presentation/widget/new_project_button.dart';
import 'package:path_provider/path_provider.dart';

class TopMenuButton extends ConsumerWidget {
  const TopMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Directory? dir;
    String filename = "Myjson.json";

    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const NewProjectButton(),
          ElevatedButton(
              onPressed: () async {
                await getApplicationDocumentsDirectory()
                    .then((Directory directory) {
                  dir = directory;
                  /*final jsonFile = File("${dir?.path}/$filename");
                    fileExist = jsonFile.existsSync();
                  print(fileExist);
                  if (fileExist) {
                    print("Exist");
                    fileContent = jsonDecode(jsonFile.readAsStringSync()); 
                  } */
                });
                final wordItems =
                    ref.watch(manageWordItemControllerProvider.notifier);

                File file = File("${dir!.path}/$filename");
                file.createSync();
                file.writeAsStringSync(jsonEncode(wordItems));
                /*final wordItems = ref.watch(wordItemNotifierProvider); */
              },
              child: const Text("Save")),
          ElevatedButton(
              onPressed: () async {
                await getApplicationDocumentsDirectory()
                    .then((Directory directory) {
                  dir = directory;
                  final jsonFile = File("${dir?.path}/$filename");
                  //fileExist = jsonFile.existsSync();
                  //if (fileExist) {
                  final List<dynamic> fileContent =
                      jsonDecode(jsonFile.readAsStringSync());
                  final List<WordModel> wordItemList = [];
                  for (final item in fileContent) {
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
                        .addLanguage(selectedLanguage: lan.language);
                  }

                  //}
                  //final wordList = jsonDecode(jsonFile.readAsStringSync());
                });
              },
              child: const Text("Load")),
          const Spacer(),
          ElevatedButton(
              onPressed: () async {
                await getApplicationDocumentsDirectory()
                    .then((Directory directory) {
                  dir = directory;
                  /*final jsonFile = File("${dir?.path}/$filename");
                    fileExist = jsonFile.existsSync();
                  print(fileExist);
                  if (fileExist) {
                    print("Exist");
                    fileContent = jsonDecode(jsonFile.readAsStringSync()); 
                  } */
                });
                final wordItems = ref.watch(manageWordItemControllerProvider);

                final j = ref.read(manageLanguageControllerProvider);

                for (int i = 0; i < j.length; i++) {
                  File file = File("${dir!.path}/${j.elementAt(i)}.json");

                  final Map<String, dynamic> q = {};

                  for (final wordItem in wordItems) {
                    q.putIfAbsent(wordItem.key, () {
                      /*    if (wordItem.translations[i] ==
                          null) {
                        return "";
                      } */
                      return wordItem.translations.elementAt(i).value;
                    });
                  }

                  file.createSync();
                  file.writeAsStringSync(jsonEncode(q));
                }

                /*final wordItems = ref.watch(wordItemNotifierProvider); */
              },
              child: const Text("Export JSONs")),
        ],
      ),
    );
  }
}
