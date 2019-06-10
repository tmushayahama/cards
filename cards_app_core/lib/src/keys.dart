// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';

class ArchSampleKeys {
  // Home Screens
  static final homeScreen = const Key('__homeScreen__');
  static final addCardFab = const Key('__addCardFab__');
  static final snackbar = const Key('__snackbar__');
  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');

  // Cards
  static final cardList = const Key('__cardList__');
  static final cardsLoading = const Key('__cardsLoading__');
  static final cardItem = (String id) => Key('CardItem__${id}');
  static final cardItemCheckbox =
      (String id) => Key('CardItem__${id}__Checkbox');
  static final cardItemTask = (String id) => Key('CardItem__${id}__Task');
  static final cardItemNote = (String id) => Key('CardItem__${id}__Note');

  // Tabs
  static final tabs = const Key('__tabs__');
  static final cardTab = const Key('__cardTab__');
  static final statsTab = const Key('__statsTab__');

  // Extra Actions
  static final extraActionsButton = const Key('__extraActionsButton__');
  static final toggleAll = const Key('__markAllDone__');
  static final clearCompleted = const Key('__clearCompleted__');

  // Filters
  static final filterButton = const Key('__filterButton__');
  static final allFilter = const Key('__allFilter__');
  static final activeFilter = const Key('__activeFilter__');
  static final completedFilter = const Key('__completedFilter__');

  // Stats
  static final statsCounter = const Key('__statsCounter__');
  static final statsLoading = const Key('__statsLoading__');
  static final statsNumActive = const Key('__statsActiveItems__');
  static final statsNumCompleted = const Key('__statsCompletedItems__');

  // Details Screen
  static final editCardFab = const Key('__editCardFab__');
  static final deleteCardButton = const Key('__deleteCardFab__');
  static final cardDetailsScreen = const Key('__cardDetailsScreen__');
  static final detailsCardItemCheckbox = Key('DetailsCard__Checkbox');
  static final detailsCardItemTask = Key('DetailsCard__Task');
  static final detailsCardItemNote = Key('DetailsCard__Note');

  // Add Screen
  static final addCardScreen = const Key('__addCardScreen__');
  static final saveNewCard = const Key('__saveNewCard__');
  static final taskField = const Key('__taskField__');
  static final noteField = const Key('__noteField__');

  // Edit Screen
  static final editCardScreen = const Key('__editCardScreen__');
  static final saveCardFab = const Key('__saveCardFab__');
}
