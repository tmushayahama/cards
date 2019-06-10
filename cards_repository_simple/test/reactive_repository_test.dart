// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:cards_repository_core/cards_repository_core.dart';
import 'package:cards_repository_simple/cards_repository_simple.dart';

class MockCardsRepository extends Mock implements CardsRepository {}

main() {
  group('ReactiveCardsRepository', () {
    List<CardEntity> createCards([String task = "Task"]) {
      return [
        CardEntity(task, "1", "Hallo", false),
        CardEntity(task, "2", "Friend", false),
        CardEntity(task, "3", "Yo", false),
      ];
    }

    test('should load cards from the base repo and send them to the client',
        () {
      final cards = createCards();
      final repository = MockCardsRepository();
      final reactiveRepository = ReactiveCardsRepositoryFlutter(
        repository: repository,
        seedValue: cards,
      );

      when(repository.loadCards())
          .thenAnswer((_) => Future.value(<CardEntity>[]));

      expect(reactiveRepository.cards(), emits(cards));
    });

    test('should only load from the base repo once', () {
      final cards = createCards();
      final repository = MockCardsRepository();
      final reactiveRepository = ReactiveCardsRepositoryFlutter(
        repository: repository,
        seedValue: cards,
      );

      when(repository.loadCards()).thenAnswer((_) => Future.value(cards));

      expect(reactiveRepository.cards(), emits(cards));
      expect(reactiveRepository.cards(), emits(cards));

      verify(repository.loadCards()).called(1);
    });

    test('should add cards to the repository and emit the change', () async {
      final cards = createCards();
      final repository = MockCardsRepository();
      final reactiveRepository = ReactiveCardsRepositoryFlutter(
        repository: repository,
        seedValue: [],
      );

      when(repository.loadCards())
          .thenAnswer((_) => new Future.value(<CardEntity>[]));
      when(repository.saveCards(cards)).thenAnswer((_) => Future.value());

      await reactiveRepository.addNewCard(cards.first);

      verify(repository.saveCards(any));
      expect(reactiveRepository.cards(), emits([cards.first]));
    });

    test('should update a card in the repository and emit the change',
        () async {
      final cards = createCards();
      final repository = MockCardsRepository();
      final reactiveRepository = ReactiveCardsRepositoryFlutter(
        repository: repository,
        seedValue: cards,
      );
      final update = createCards("task");

      when(repository.loadCards()).thenAnswer((_) => Future.value(cards));
      when(repository.saveCards(any)).thenAnswer((_) => Future.value());

      await reactiveRepository.updateCard(update.first);

      verify(repository.saveCards(any));
      expect(
        reactiveRepository.cards(),
        emits([update[0], cards[1], cards[2]]),
      );
    });

    test('should remove cards from the repo and emit the change', () async {
      final repository = MockCardsRepository();
      final cards = createCards();
      final reactiveRepository = ReactiveCardsRepositoryFlutter(
        repository: repository,
        seedValue: cards,
      );
      final future = Future.value(cards);

      when(repository.loadCards()).thenAnswer((_) => future);
      when(repository.saveCards(any)).thenAnswer((_) => Future.value());

      await reactiveRepository.deleteCard([cards.first.id, cards.last.id]);

      verify(repository.saveCards(any));
      expect(reactiveRepository.cards(), emits([cards[1]]));
    });
  });
}
