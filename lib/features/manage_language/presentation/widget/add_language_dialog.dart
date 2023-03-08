import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/features/manage_language/presentation/controller/manage_language_controller.dart';
import 'package:i18n_app/utils/const.dart';

class AddLanaguageDialog extends ConsumerWidget {
  const AddLanaguageDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Set<String> languagesAvailable = {};

    for (final language in Const.language) {
      if (!ref.read(manageLanguageControllerProvider).contains(language)) {
        languagesAvailable.add(language);
      }
    }
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
                "Add Language",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
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
                itemCount: languagesAvailable.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      onTap: () {
                        ref
                            .read(manageLanguageControllerProvider.notifier)
                            .addLanguage(
                                selectedLanguage:
                                    languagesAvailable.elementAt(index));
                        Navigator.of(context).pop();
                      },
                      title: Text(languagesAvailable.elementAt(index)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
