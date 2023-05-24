import 'package:flutter/material.dart';

class NoSelectedItem extends StatelessWidget {
  const NoSelectedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: double.infinity, child: Text("no selection"));
  }
}
