import 'package:flutter/material.dart';
import 'package:i18n_app/widgets/left_panel.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(flex: 3, child: LeftPanel()),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(28),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Colors.black.withAlpha(125))),
                )),
          ],
        ),
      ),
    );
  }
}
