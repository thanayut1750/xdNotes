import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:xdnotes/services/cloud/cloud_storage_constants.dart';
import 'package:flutter/foundation.dart';

@immutable
class CloudNote {
  final String documentId;
  late final String ownerUserId;
  final String text;
  const CloudNote({
    required this.documentId,
    required this.ownerUserId,
    required this.text,
  });

  CloudNote.fromSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        text = snapshot.data()[textFieldName] as String;
}
