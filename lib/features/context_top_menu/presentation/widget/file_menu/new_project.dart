import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_hub/core/utils/languages_enum.dart';
import 'package:i18n_hub/core/widget/snackbar_widget.dart';
import 'package:i18n_hub/features/context_top_menu/presentation/controller/context_top_menu_controller.dart';
import 'package:i18n_hub/features/context_top_menu/domain/model/menu_entry.dart';
import 'package:i18n_hub/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_hub/features/manage_word_item/presentation/controller/selection_word_item_controller.dart';

MenuEntry getNewProjectMenu(BuildContext context, WidgetRef ref) {
  return MenuEntry(
    label: 'New Project',
    onPressed: () async {
      await showDialog(
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
                                              (code: e.code, name: e.name))
                                          .elementAt(index));
                              ref
                                  .read(
                                      contextTopMenuControllerProvider.notifier)
                                  .makeNewProject(
                                      selectedLanguage: LanguagesAvailable
                                          .values
                                          .elementAt(index)
                                          .name);

                              Navigator.of(context).pop();
                            },
                            title: Text(LanguagesAvailable.values[index].name));
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );

      if (context.mounted) {
        I18NSnackBar.displaySuccessSnackbar(context,
            successMessage: "Project created");
      }
    },
  );
}
