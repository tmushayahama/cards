import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_cards/blocs/filtered_cards/filtered_cards.dart';
import 'package:flutter_cards/blocs/cards/cards.dart';
import 'package:flutter_cards/models/models.dart';

class FilteredCardsBloc extends Bloc<FilteredCardsEvent, FilteredCardsState> {
  final CardsBloc cardsBloc;
  StreamSubscription cardsSubscription;

  FilteredCardsBloc({@required this.cardsBloc}) {
    cardsSubscription = cardsBloc.state.listen((state) {
      if (state is CardsLoaded) {
        dispatch(UpdateCards((cardsBloc.currentState as CardsLoaded).cards));
      }
    });
  }

  @override
  FilteredCardsState get initialState {
    return cardsBloc.currentState is CardsLoaded
        ? FilteredCardsLoaded(
            (cardsBloc.currentState as CardsLoaded).cards,
            VisibilityFilter.all,
          )
        : FilteredCardsLoading();
  }

  @override
  Stream<FilteredCardsState> mapEventToState(FilteredCardsEvent event) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateCards) {
      yield* _mapCardsUpdatedToState(event);
    }
  }

  Stream<FilteredCardsState> _mapUpdateFilterToState(
    UpdateFilter event,
  ) async* {
    if (cardsBloc.currentState is CardsLoaded) {
      yield FilteredCardsLoaded(
        _mapCardsToFilteredCards(
          (cardsBloc.currentState as CardsLoaded).cards,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<FilteredCardsState> _mapCardsUpdatedToState(
    UpdateCards event,
  ) async* {
    final visibilityFilter = currentState is FilteredCardsLoaded
        ? (currentState as FilteredCardsLoaded).activeFilter
        : VisibilityFilter.all;
    yield FilteredCardsLoaded(
      _mapCardsToFilteredCards(
        (cardsBloc.currentState as CardsLoaded).cards,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Card> _mapCardsToFilteredCards(
      List<Card> cards, VisibilityFilter filter) {
    return cards.where((card) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !card.complete;
      } else if (filter == VisibilityFilter.completed) {
        return card.complete;
      }
    }).toList();
  }

  @override
  void dispose() {
    cardsSubscription.cancel();
    super.dispose();
  }
}
