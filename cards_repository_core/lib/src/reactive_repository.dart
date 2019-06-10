// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:core';

import 'card_entity.dart';

/// A data layer class works with reactive data sources, such as Firebase. This
/// class emits a Stream of CardEntities. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as firebase_repository_flutter.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class ReactiveCardsRepository {
  Future<void> addNewCard(CardEntity card);

  Future<void> deleteCard(List<String> idList);

  Stream<List<CardEntity>> cards();

  Future<void> updateCard(CardEntity card);
}
