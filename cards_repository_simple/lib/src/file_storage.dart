import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cards_repository_core/cards_repository_core.dart';

/// Loads and saves a List of Cards using a text file stored on the device.
///
/// Note: This class has no direct dependencies on any Flutter dependencies.
/// Instead, the `getDirectory` method should be injected. This allows for
/// testing.
class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
    this.tag,
    this.getDirectory,
  );

  Future<List<CardEntity>> loadCards() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final cards = (json['cards'])
        .map<CardEntity>((card) => CardEntity.fromJson(card))
        .toList();

    return cards;
  }

  Future<File> saveCards(List<CardEntity> cards) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      'cards': cards.map((card) => card.toJson()).toList(),
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/ArchSampleStorage__$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}
