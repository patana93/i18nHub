import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';
import 'package:path_provider/path_provider.dart';

class TopMenuButton extends ConsumerWidget {
  const TopMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Directory? dir;

    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(onPressed: () async {}, child: const Text("Load")),
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
                  File file =
                      File("${dir!.path}/${j.values.elementAt(i)}.json");

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
