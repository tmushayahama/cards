import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_cards/models/models.dart';

@immutable
abstract class CardsEvent extends Equatable {
  CardsEvent([List props = const []]) : super(props);
}

class LoadCards extends CardsEvent {
  @override
  String toString() => 'LoadCards';
}

class AddCard extends CardsEvent {
  final Card card;

  AddCard(this.card) : super([card]);

  @override
  String toString() => 'AddCard { card: $card }';
}

class UpdateCard extends CardsEvent {
  final Card updatedCard;

  UpdateCard(this.updatedCard) : super([updatedCard]);

  @override
  String toString() => 'UpdateCard { updatedCard: $updatedCard }';
}

class DeleteCard extends CardsEvent {
  final Card card;

  DeleteCard(this.card) : super([card]);

  @override
  String toString() => 'DeleteCard { card: $card }';
}

class ClearCompleted extends CardsEvent {
  @override
  String toString() => 'ClearCompleted';
}

class ToggleAll extends CardsEvent {
  @override
  String toString() => 'ToggleAll';
}
