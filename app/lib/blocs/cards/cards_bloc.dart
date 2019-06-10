import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_cards/blocs/cards/cards.dart';
import 'package:flutter_cards/models/models.dart';
import 'package:cards_repository_simple/cards_repository_simple.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  final CardsRepositoryFlutter cardsRepository;

  CardsBloc({@required this.cardsRepository});

  @override
  CardsState get initialState => CardsLoading();

  @override
  Stream<CardsState> mapEventToState(CardsEvent event) async* {
    if (event is LoadCards) {
      yield* _mapLoadCardsToState();
    } else if (event is AddCard) {
      yield* _mapAddCardToState(event);
    } else if (event is UpdateCard) {
      yield* _mapUpdateCardToState(event);
    } else if (event is DeleteCard) {
      yield* _mapDeleteCardToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<CardsState> _mapLoadCardsToState() async* {
    try {
      final cards = await this.cardsRepository.loadCards();
      yield CardsLoaded(
        cards.map(Card.fromEntity).toList(),
      );
    } catch (_) {
      yield CardsNotLoaded();
    }
  }

  Stream<CardsState> _mapAddCardToState(AddCard event) async* {
    if (currentState is CardsLoaded) {
      final List<Card> updatedCards =
          List.from((currentState as CardsLoaded).cards)..add(event.card);
      yield CardsLoaded(updatedCards);
      _saveCards(updatedCards);
    }
  }

  Stream<CardsState> _mapUpdateCardToState(UpdateCard event) async* {
    if (currentState is CardsLoaded) {
      final List<Card> updatedCards =
          (currentState as CardsLoaded).cards.map((card) {
        return card.id == event.updatedCard.id ? event.updatedCard : card;
      }).toList();
      yield CardsLoaded(updatedCards);
      _saveCards(updatedCards);
    }
  }

  Stream<CardsState> _mapDeleteCardToState(DeleteCard event) async* {
    if (currentState is CardsLoaded) {
      final updatedCards = (currentState as CardsLoaded)
          .cards
          .where((card) => card.id != event.card.id)
          .toList();
      yield CardsLoaded(updatedCards);
      _saveCards(updatedCards);
    }
  }

  Stream<CardsState> _mapToggleAllToState() async* {
    if (currentState is CardsLoaded) {
      final allComplete =
          (currentState as CardsLoaded).cards.every((card) => card.complete);
      final List<Card> updatedCards = (currentState as CardsLoaded)
          .cards
          .map((card) => card.copyWith(complete: !allComplete))
          .toList();
      yield CardsLoaded(updatedCards);
      _saveCards(updatedCards);
    }
  }

  Stream<CardsState> _mapClearCompletedToState() async* {
    if (currentState is CardsLoaded) {
      final List<Card> updatedCards = (currentState as CardsLoaded)
          .cards
          .where((card) => !card.complete)
          .toList();
      yield CardsLoaded(updatedCards);
      _saveCards(updatedCards);
    }
  }

  Future _saveCards(List<Card> cards) {
    return cardsRepository.saveCards(
      cards.map((card) => card.toEntity()).toList(),
    );
  }
}
