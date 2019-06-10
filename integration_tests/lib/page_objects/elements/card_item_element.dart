// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:flutter_driver/flutter_driver.dart';

import '../screens/details_test_screen.dart';
import '../utils.dart';
import 'test_element.dart';

class CardItemElement extends TestElement {
  final String id;

  CardItemElement(this.id, FlutterDriver driver) : super(driver);

  SerializableFinder get _taskFinder =>
      find.byValueKey('CardItem__${id}__Task');

  SerializableFinder get _checkboxFinder =>
      find.byValueKey('CardItem__${id}__Checkbox');

  SerializableFinder get _cardItemFinder => find.byValueKey('CardItem__${id}');

  Future<bool> get isVisible => widgetExists(driver, _cardItemFinder);

  Future<bool> get isAbsent => widgetAbsent(driver, _cardItemFinder);

  Future<String> get task async => await driver.getText(_taskFinder);

  Future<String> get note async =>
      await driver.getText(find.byValueKey('CardItem__${id}__Note'));

  Future<CardItemElement> tapCheckbox() async {
    await driver.tap(_checkboxFinder);
    await driver.waitUntilNoTransientCallbacks();

    return this;
  }

  DetailsTestScreen tap() {
    driver.tap(_taskFinder);

    return new DetailsTestScreen(driver);
  }
}
