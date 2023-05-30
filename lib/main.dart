import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_app/core/utils/shared_prefs.dart';
import 'package:i18n_app/features/context_top_menu/presentation/page/top_menu_bar.dart';
import 'package:i18n_app/features/manage_word_item/presentation/page/manage_word_item_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: FutureBuilder(
            future: _setSaveDir(),
            builder: (context, snapshot) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TopMenuBar(),
                    SizedBox(
                      height: 4,
                    ),
                    ManageWordItemPage()
                  ],
                ),
              );
            },
          ),
        ));
  }

  Future<void> _setSaveDir() async {
    final saveDir = SharedPrefs.getString(SharedPrefs.savePath);
    if (saveDir == null) {
      await getApplicationDocumentsDirectory().then(
          (value) => SharedPrefs.setString(SharedPrefs.savePath, value.path));
    }
  }
}
