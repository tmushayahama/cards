// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:flutter_driver/flutter_driver.dart';

import '../utils.dart';
import 'edit_test_screen.dart';
import 'test_screen.dart';

class DetailsTestScreen extends TestScreen {
  final _detailsScreenFinder = find.byValueKey('__cardDetailsScreen__');
  final _deleteButtonFinder = find.byValueKey('__deleteCardFab__');
  final _checkboxFinder = find.byValueKey('DetailsCard__Checkbox');
  final _taskFinder = find.byValueKey('DetailsCard__Task');
  final _noteFinder = find.byValueKey('DetailsCard__Note');
  final _editCardFabFinder = find.byValueKey('__editCardFab__');
  final _backButtonFinder = find.byTooltip('Back');

  DetailsTestScreen(FlutterDriver driver) : super(driver);

  @override
  Future<bool> isReady({Duration timeout}) =>
      widgetExists(driver, _detailsScreenFinder, timeout: timeout);

  Future<String> get task => driver.getText(_taskFinder);

  Future<String> get note => driver.getText(_noteFinder);

  Future<DetailsTestScreen> tapCheckbox() async {
    await driver.tap(_checkboxFinder);

    return this;
  }

  EditTestScreen tapEditCardButton() {
    driver.tap(_editCardFabFinder);

    return new EditTestScreen(driver);
  }

  Future<Null> tapDeleteButton() async {
    await driver.tap(_deleteButtonFinder);
  }

  Future<Null> tapBackButton() async {
    return await driver.tap(_backButtonFinder);
  }
}
