import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cards_app_core/cards_app_core.dart';
import 'package:flutter_cards/blocs/blocs.dart';
import 'package:flutter_cards/widgets/widgets.dart';
import 'package:flutter_cards/screens/screens.dart';
import 'package:flutter_cards/flutter_cards_keys.dart';

class FilteredCards extends StatelessWidget {
  FilteredCards({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardsBloc = BlocProvider.of<CardsBloc>(context);
    final filteredCardsBloc = BlocProvider.of<FilteredCardsBloc>(context);
    final localizations = ArchSampleLocalizations.of(context);

    return BlocBuilder(
      bloc: filteredCardsBloc,
      builder: (
        BuildContext context,
        FilteredCardsState state,
      ) {
        if (state is FilteredCardsLoading) {
          return LoadingIndicator(key: ArchSampleKeys.cardsLoading);
        } else if (state is FilteredCardsLoaded) {
          final cards = state.filteredCards;
          return ListView.builder(
            key: ArchSampleKeys.cardList,
            itemCount: cards.length,
            itemBuilder: (BuildContext context, int index) {
              final card = cards[index];
              return CardItem(
                card: card,
                onDismissed: (direction) {
                  cardsBloc.dispatch(DeleteCard(card));
                  Scaffold.of(context).showSnackBar(DeleteCardSnackBar(
                    key: ArchSampleKeys.snackbar,
                    card: card,
                    onUndo: () => cardsBloc.dispatch(AddCard(card)),
                    localizations: localizations,
                  ));
                },
                onTap: () async {
                  final removedCard = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(id: card.id);
                    }),
                  );
                  if (removedCard != null) {
                    Scaffold.of(context).showSnackBar(DeleteCardSnackBar(
                      key: ArchSampleKeys.snackbar,
                      card: card,
                      onUndo: () => cardsBloc.dispatch(AddCard(card)),
                      localizations: localizations,
                    ));
                  }
                },
                onCheckboxChanged: (_) {
                  cardsBloc.dispatch(
                    UpdateCard(card.copyWith(complete: !card.complete)),
                  );
                },
              );
            },
          );
        } else {
          return Container(key: FlutterCardsKeys.filteredCardsEmptyContainer);
        }
      },
    );
  }
}
