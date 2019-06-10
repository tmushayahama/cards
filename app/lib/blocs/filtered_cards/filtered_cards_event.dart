import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_cards/models/models.dart';

@immutable
abstract class FilteredCardsEvent extends Equatable {
  FilteredCardsEvent([List props = const []]) : super(props);
}

class UpdateFilter extends FilteredCardsEvent {
  final VisibilityFilter filter;

  UpdateFilter(this.filter) : super([filter]);

  @override
  String toString() => 'UpdateFilter { filter: $filter }';
}

class UpdateCards extends FilteredCardsEvent {
  final List<Card> cards;

  UpdateCards(this.cards) : super([cards]);

  @override
  String toString() => 'UpdateCards { cards: $cards }';
}
