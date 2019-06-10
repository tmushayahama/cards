import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_cards/models/models.dart';

@immutable
abstract class CardsState extends Equatable {
  CardsState([List props = const []]) : super(props);
}

class CardsLoading extends CardsState {
  @override
  String toString() => 'CardsLoading';
}

class CardsLoaded extends CardsState {
  final List<Card> cards;

  CardsLoaded([this.cards = const []]) : super([cards]);

  @override
  String toString() => 'CardsLoaded { cards: $cards }';
}

class CardsNotLoaded extends CardsState {
  @override
  String toString() => 'CardsNotLoaded';
}
