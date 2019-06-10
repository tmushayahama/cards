// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_tests/page_objects/page_objects.dart';

import '../elements/extra_actions_element.dart';
import '../elements/filters_element.dart';
import '../elements/stats_element.dart';
import '../elements/card_list_element.dart';
import '../utils.dart';
import 'test_screen.dart';

class HomeTestScreen extends TestScreen {
  final _filterButtonFinder = find.byValueKey('__filterButton__');
  final _extraActionsButtonFinder = find.byValueKey('__extraActionsButton__');
  final _cardsTabFinder = find.byValueKey('__cardTab__');
  final _statsTabFinder = find.byValueKey('__statsTab__');
  final _snackbarFinder = find.byValueKey('__snackbar__');
  final _addCardButtonFinder = find.byValueKey('__addCardFab__');

  HomeTestScreen(FlutterDriver driver) : super(driver);

  @override
  Future<bool> isLoading({Duration timeout}) async =>
      new CardListElement(driver).isLoading;

  @override
  Future<bool> isReady({Duration timeout}) =>
      new CardListElement(driver).isReady;

  CardListElement get cardList {
    return new CardListElement(driver);
  }

  StatsElement get stats {
    return new StatsElement(driver);
  }

  CardListElement tapCardsTab() {
    driver.tap(_cardsTabFinder);

    return new CardListElement(driver);
  }

  StatsElement tapStatsTab() {
    driver.tap(_statsTabFinder);

    return new StatsElement(driver);
  }

  FiltersElement tapFilterButton() {
    driver.tap(_filterButtonFinder);

    return new FiltersElement(driver);
  }

  ExtraActionsElement tapExtraActionsButton() {
    driver.tap(_extraActionsButtonFinder);

    return new ExtraActionsElement(driver);
  }

  Future<bool> get snackbarVisible {
    return widgetExists(driver, _snackbarFinder);
  }

  AddTestScreen tapAddCardButton() {
    driver.tap(_addCardButtonFinder);

    return new AddTestScreen(driver);
  }

  DetailsTestScreen tapCard(String text) {
    driver.tap(find.text(text));
    return DetailsTestScreen(driver);
  }
}
