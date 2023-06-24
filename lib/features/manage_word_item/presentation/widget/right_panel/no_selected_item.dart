import 'package:flutter/material.dart';

class NoSelectedItem extends StatelessWidget {
  const NoSelectedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "No word selected",
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: Colors.grey,
          ),
    ));
  }
}
