import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_cards/blocs/blocs.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final CardsBloc cardsBloc;
  StreamSubscription cardsSubscription;

  StatsBloc({@required this.cardsBloc}) {
    cardsSubscription = cardsBloc.state.listen((state) {
      if (state is CardsLoaded) {
        dispatch(UpdateStats(state.cards));
      }
    });
  }

  @override
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats) {
      int numActive =
          event.cards.where((card) => !card.complete).toList().length;
      int numCompleted =
          event.cards.where((card) => card.complete).toList().length;
      yield StatsLoaded(numActive, numCompleted);
    }
  }

  @override
  void dispose() {
    cardsSubscription.cancel();
    super.dispose();
  }
}
