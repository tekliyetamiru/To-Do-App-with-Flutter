// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

class MyBotton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyBotton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        color: Theme.of(context).canvasColor,
        child: Text(text));
  }
}
