// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';
import 'package:cards_repository_core/cards_repository_core.dart';
import 'package:cards_repository_simple/cards_repository_simple.dart';

main() {
  group('FileStorage', () {
    final cards = [CardEntity("Task", "1", "Hallo", false)];
    final directory = Directory.systemTemp.createTemp('__storage_test__');
    final storage = FileStorage(
      '_test_tag_',
      () => directory,
    );

    tearDownAll(() async {
      final tempDirectory = await directory;

      tempDirectory.deleteSync(recursive: true);
    });

    test('Should persist CardEntities to disk', () async {
      final file = await storage.saveCards(cards);

      expect(file.existsSync(), isTrue);
    });

    test('Should load CardEntities from disk', () async {
      final loadedCards = await storage.loadCards();

      expect(loadedCards, cards);
    });
  });
}
