// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:core';

import 'package:meta/meta.dart';
import 'package:cards_repository_core/cards_repository_core.dart';
import 'file_storage.dart';
import 'web_client.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Cards and Persist cards.
class CardsRepositoryFlutter implements CardsRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const CardsRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  /// Loads cards first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Cards from a Web Client.
  @override
  Future<List<CardEntity>> loadCards() async {
    try {
      return await fileStorage.loadCards();
    } catch (e) {
      final cards = await webClient.fetchCards();

      fileStorage.saveCards(cards);

      return cards;
    }
  }

  // Persists cards to local disk and the web
  @override
  Future saveCards(List<CardEntity> cards) {
    return Future.wait<dynamic>([
      fileStorage.saveCards(cards),
      webClient.postCards(cards),
    ]);
  }
}
