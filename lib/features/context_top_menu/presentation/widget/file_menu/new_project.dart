import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/core/utils/languages_enum.dart';
import 'package:i18n_app/features/context_top_menu/presentation/controller/context_top_menu_controller.dart';
import 'package:i18n_app/features/context_top_menu/domain/model/menu_entry.dart';
import 'package:i18n_app/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_app/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';

MenuEntry getNewProjectMenu(BuildContext context, WidgetRef ref) {
  return MenuEntry(
    label: 'New Project',
    onPressed: () {
      showDialog(
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
                      "Select default language",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    "You cannot change this after",
                    style: TextStyle(fontSize: 16),
                  ),
                  /*     
                  Search language
                  Padding(
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
                      itemCount: LanguagesAvailable.values.length,
                      itemBuilder: (context, index) {
                        print(LanguagesAvailable.values[index]);
                        return ListTile(
                            onTap: () {
                              ref
                                  .read(selectionWordItemControllerProvider
                                      .notifier)
                                  .selectWordItem(null, null);
                              ref
                                  .read(
                                      manageLanguageControllerProvider.notifier)
                                  .resetToDefault(
                                      defaultLanguage: LanguagesAvailable.values
                                          .map((e) =>
                                              MapEntry(e.language, e.code))
                                          .elementAt(index));
                              ref
                                  .read(
                                      contextTopMenuControllerProvider.notifier)
                                  .makeNewProject(
                                      selectedLanguage: LanguagesAvailable
                                          .values
                                          .map((e) => e.language)
                                          .elementAt(index));

                              Navigator.of(context).pop();
                            },
                            title: Text(
                                LanguagesAvailable.values[index].language));
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
  );
}
