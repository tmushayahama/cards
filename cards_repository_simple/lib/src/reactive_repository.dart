// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:core';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:cards_repository_core/cards_repository_core.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Cards and Persist cards.
class ReactiveCardsRepositoryFlutter implements ReactiveCardsRepository {
  final CardsRepository _repository;
  final BehaviorSubject<List<CardEntity>> _subject;
  bool _loaded = false;

  ReactiveCardsRepositoryFlutter({
    @required CardsRepository repository,
    List<CardEntity> seedValue,
  })  : this._repository = repository,
        this._subject = BehaviorSubject<List<CardEntity>>();

  @override
  Future<void> addNewCard(CardEntity card) async {
    _subject.add(List.unmodifiable([]
      ..addAll(_subject.value ?? [])
      ..add(card)));

    await _repository.saveCards(_subject.value);
  }

  @override
  Future<void> deleteCard(List<String> idList) async {
    _subject.add(
      List<CardEntity>.unmodifiable(_subject.value.fold<List<CardEntity>>(
        <CardEntity>[],
        (prev, entity) {
          return idList.contains(entity.id) ? prev : (prev..add(entity));
        },
      )),
    );

    await _repository.saveCards(_subject.value);
  }

  @override
  Stream<List<CardEntity>> cards() {
    if (!_loaded) _loadCards();

    return _subject.stream;
  }

  void _loadCards() {
    _loaded = true;

    _repository.loadCards().then((entities) {
      _subject.add(List<CardEntity>.unmodifiable(
        []..addAll(_subject.value ?? [])..addAll(entities),
      ));
    });
  }

  @override
  Future<void> updateCard(CardEntity update) async {
    _subject.add(
      List<CardEntity>.unmodifiable(_subject.value.fold<List<CardEntity>>(
        <CardEntity>[],
        (prev, entity) => prev..add(entity.id == update.id ? update : entity),
      )),
    );

    await _repository.saveCards(_subject.value);
  }
}
