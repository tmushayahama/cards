import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_cards/blocs/tab/tab.dart';
import 'package:flutter_cards/models/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.cards;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
