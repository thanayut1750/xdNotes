import 'package:flutter/material.dart';
import 'package:xdnotes/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: "An error occurred",
    content: text,
    optionsBuilder: () => {
      "oK": null,
    },
  );
}
