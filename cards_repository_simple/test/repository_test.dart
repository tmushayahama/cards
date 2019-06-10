// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:cards_repository_core/cards_repository_core.dart';
import 'package:cards_repository_simple/cards_repository_simple.dart';

/// We create two Mocks for our Web Client and File Storage. We will use these
/// mock classes to verify the behavior of the CardsRepository.
class MockFileStorage extends Mock implements FileStorage {}

class MockWebClient extends Mock implements WebClient {}

main() {
  group('CardsRepository', () {
    List<CardEntity> createCards() {
      return [CardEntity("Task", "1", "Hallo", false)];
    }

    test(
        'should load cards from File Storage if they exist without calling the web client',
        () {
      final fileStorage = MockFileStorage();
      final webClient = MockWebClient();
      final repository = CardsRepositoryFlutter(
        fileStorage: fileStorage,
        webClient: webClient,
      );
      final cards = createCards();

      // We'll use our mock throughout the tests to set certain conditions. In
      // this first test, we want to mock out our file storage to return a
      // list of Cards that we define here in our test!
      when(fileStorage.loadCards()).thenAnswer((_) => Future.value(cards));

      expect(repository.loadCards(), completion(cards));
      verifyNever(webClient.fetchCards());
    });

    test(
        'should fetch cards from the Web Client if the file storage throws a synchronous error',
        () async {
      final fileStorage = MockFileStorage();
      final webClient = MockWebClient();
      final repository = CardsRepositoryFlutter(
        fileStorage: fileStorage,
        webClient: webClient,
      );
      final cards = createCards();

      // In this instance, we'll ask our Mock to throw an error. When it does,
      // we expect the web client to be called instead.
      when(fileStorage.loadCards()).thenThrow("Uh ohhhh");
      when(webClient.fetchCards()).thenAnswer((_) => Future.value(cards));

      // We check that the correct cards were returned, and that the
      // webClient.fetchCards method was in fact called!
      expect(await repository.loadCards(), cards);
      verify(webClient.fetchCards());
    });

    test(
        'should fetch cards from the Web Client if the File storage returns an async error',
        () async {
      final fileStorage = MockFileStorage();
      final webClient = MockWebClient();
      final repository = CardsRepositoryFlutter(
        fileStorage: fileStorage,
        webClient: webClient,
      );
      final cards = createCards();

      when(fileStorage.loadCards()).thenThrow(Exception("Oh no."));
      when(webClient.fetchCards()).thenAnswer((_) => Future.value(cards));

      expect(await repository.loadCards(), cards);
      verify(webClient.fetchCards());
    });

    test('should persist the cards to local disk and the web client', () {
      final fileStorage = MockFileStorage();
      final webClient = MockWebClient();
      final repository = CardsRepositoryFlutter(
        fileStorage: fileStorage,
        webClient: webClient,
      );
      final cards = createCards();

      when(fileStorage.saveCards(cards))
          .thenAnswer((_) => Future.value(File('falsch')));
      when(webClient.postCards(cards)).thenAnswer((_) => Future.value(true));

      // In this case, we just want to verify we're correctly persisting to all
      // the storage mechanisms we care about.
      expect(repository.saveCards(cards), completes);
      verify(fileStorage.saveCards(cards));
      verify(webClient.postCards(cards));
    });
  });
}
