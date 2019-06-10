import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_cards/models/models.dart';

@immutable
abstract class StatsEvent extends Equatable {
  StatsEvent([List props = const []]) : super(props);
}

class UpdateStats extends StatsEvent {
  final List<Card> cards;

  UpdateStats(this.cards) : super([cards]);

  @override
  String toString() => 'UpdateStats { cards: $cards }';
}
