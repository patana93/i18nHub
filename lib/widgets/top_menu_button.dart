import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/models/language_selected.dart';
import 'package:i18n_app/models/word_item.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/const.dart';

class TopMenuButton extends ConsumerWidget {
  const TopMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Directory? dir;
    String filename = "Myjson.json";

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () async {
            ref.read(languageSelectedNotifierProvider.notifier).clearAll();
            ref.read(wordNotifierProvider.notifier).clearAll();

            await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Dialog(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: 300,
                        maxWidth: MediaQuery.of(context).size.width / 4 + 300),
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
                                        .read(languageSelectedNotifierProvider
                                            .notifier)
                                        .addLanguage(
                                            Const.language.elementAt(index));
                                    ref
                                        .read(wordNotifierProvider.notifier)
                                        .addTranslation(
                                            Const.language.elementAt(index));
                                    Navigator.of(context).pop();
                                  },
                                  title: Text(Const.language.elementAt(index)));
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
          child: const Text("New Project"),
        ),
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
              final wordItems = ref.watch(wordNotifierProvider);

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
                final wordItemList = [];
                for (final item in fileContent) {
                  wordItemList.add(WordModel.fromJson(item));
                }

                ref.read(wordNotifierProvider.notifier).clearAll();
                for (final word in wordItemList) {
                  ref.read(wordNotifierProvider.notifier).addWord(word);
                }

                final languages = ref.read(wordNotifierProvider).first;

                ref.read(languageSelectedNotifierProvider.notifier).clearAll();

                for (final lan in languages.translations) {
                  ref
                      .read(languageSelectedNotifierProvider.notifier)
                      .addLanguage(lan.language);
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
              final wordItems = ref.watch(wordNotifierProvider);

              final j = ref.read(languageSelectedNotifierProvider);

              for (int i = 0; i < j.length; i++) {
                File file = File("${dir!.path}/${j.elementAt(i)}.json");

                final Map<String, dynamic> q = {};

                for (final wordItem in wordItems) {
                  q.putIfAbsent(wordItem.key, () {
                    /*    if (wordItem.translations[i] ==
                        null) {
                      return "";
                    } */
                    return wordItem.translations[i].value;
                  });
                }

                file.createSync();
                file.writeAsStringSync(jsonEncode(q));
              }

              /*final wordItems = ref.watch(wordItemNotifierProvider); */
            },
            child: const Text("Export JSONs")),
      ],
    );
  }
}
