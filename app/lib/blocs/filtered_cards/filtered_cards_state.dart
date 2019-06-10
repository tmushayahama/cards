import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_cards/models/models.dart';

@immutable
abstract class FilteredCardsState extends Equatable {
  FilteredCardsState([List props = const []]) : super(props);
}

class FilteredCardsLoading extends FilteredCardsState {
  @override
  String toString() => 'FilteredCardsLoading';
}

class FilteredCardsLoaded extends FilteredCardsState {
  final List<Card> filteredCards;
  final VisibilityFilter activeFilter;

  FilteredCardsLoaded(this.filteredCards, this.activeFilter)
      : super([filteredCards, activeFilter]);

  @override
  String toString() {
    return 'FilteredCardsLoaded { filteredCards: $filteredCards, activeFilter: $activeFilter }';
  }
}
