import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/manage_word_item_controller.dart';

import '../../../../utils/const.dart';
import '../../../manage_language/presentation/controller/manage_language_controller.dart';
import '../controller/new_project_controller.dart';

class NewProjectButton extends ConsumerWidget {
  const NewProjectButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        ref.read(manageWordItemControllerProvider.notifier).clearAll();

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
                                    .read(manageLanguageControllerProvider
                                        .notifier)
                                    .resetToDefault(
                                        defaultLanguage:
                                            Const.language.elementAt(index));
                                ref
                                    .read(makeNewProjectControllerProvider
                                        .notifier)
                                    .makeNewProject(
                                        selectedLanguage:
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
    );
  }
}
