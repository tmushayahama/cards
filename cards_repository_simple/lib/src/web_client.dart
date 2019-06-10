// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:cards_repository_core/cards_repository_core.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Cards to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class WebClient {
  final Duration delay;

  const WebClient([this.delay = const Duration(milliseconds: 3000)]);

  /// Mock that "fetches" some Cards from a "web service" after a short delay
  Future<List<CardEntity>> fetchCards() async {
    return Future.delayed(
        delay,
        () => [
              CardEntity(
                'Buy food for da kitty',
                '1',
                'With the chickeny bits!',
                false,
              ),
              CardEntity(
                'Find a Red Sea dive trip',
                '2',
                'Echo vs MY Dream',
                false,
              ),
              CardEntity(
                'Book flights to Egypt',
                '3',
                '',
                true,
              ),
              CardEntity(
                'Decide on accommodation',
                '4',
                '',
                false,
              ),
              CardEntity(
                'Sip Margaritas',
                '5',
                'on the beach',
                true,
              ),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postCards(List<CardEntity> cards) async {
    return Future.value(true);
  }
}
