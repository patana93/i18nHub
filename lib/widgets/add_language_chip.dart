import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/models/language_selected.dart';

import '../utils/const.dart';

class AddLanguageChip extends ConsumerWidget {
  const AddLanguageChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionChip(
      elevation: 8.0,
      padding: const EdgeInsets.all(2.0),
      avatar: const Icon(
        Icons.add,
        color: Colors.blue,
        size: 20,
      ),
      label: const Text('Add Language'),
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
                        "Add Language",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
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
                    ),
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
      backgroundColor: Colors.grey[200],
    );
  }
}
