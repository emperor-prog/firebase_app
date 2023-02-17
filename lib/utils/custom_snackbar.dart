import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showToastBar(
    {required String message,
    required BuildContext context,
    required VoidCallback onSucess}) {
  final snackbar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
  onSucess();
}
