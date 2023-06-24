import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:i18n_hub/core/utils/shared_prefs.dart';
import 'package:i18n_hub/features/context_top_menu/domain/model/menu_entry.dart';

MenuEntry getSelecteSavePathMenu(BuildContext context) {
  final savePathController =
      TextEditingController(text: SharedPrefs.getString(SharedPrefs.savePath));
  return MenuEntry(
      label: "Set Save Folder",
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
                      final a = await FilePicker.platform.getDirectoryPath(
                        dialogTitle: 'Select folder',
                      );
                      if (a != null) {
                        SharedPrefs.setString(SharedPrefs.savePath, a);
                      }

                      savePathController.text = a ?? savePathController.text;
                    },
                    child: const Text("Choose dir..."))
              ],
            ),
          ),
        );
      });
}
