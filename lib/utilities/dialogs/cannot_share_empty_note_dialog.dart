import 'package:flutter/cupertino.dart';
import 'package:xdnotes/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Sharing",
    content: 'Can not share empty note',
    optionsBuilder: () => {"OK": null},
  );
}
