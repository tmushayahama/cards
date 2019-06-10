import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cards_app_core/cards_app_core.dart';
import 'package:flutter_cards/blocs/cards/cards.dart';
import 'package:flutter_cards/screens/screens.dart';
import 'package:flutter_cards/flutter_cards_keys.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen({Key key, @required this.id})
      : super(key: key ?? ArchSampleKeys.cardDetailsScreen);

  @override
  Widget build(BuildContext context) {
    final cardsBloc = BlocProvider.of<CardsBloc>(context);
    return BlocBuilder(
      bloc: cardsBloc,
      builder: (BuildContext context, CardsState state) {
        final card = (state as CardsLoaded)
            .cards
            .firstWhere((card) => card.id == id, orElse: () => null);
        final localizations = ArchSampleLocalizations.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(localizations.cardDetails),
            actions: [
              IconButton(
                tooltip: localizations.deleteCard,
                key: ArchSampleKeys.deleteCardButton,
                icon: Icon(Icons.delete),
                onPressed: () {
                  cardsBloc.dispatch(DeleteCard(card));
                  Navigator.pop(context, card);
                },
              )
            ],
          ),
          body: card == null
              ? Container(key: FlutterCardsKeys.emptyDetailsContainer)
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Checkbox(
                                key: FlutterCardsKeys.detailsScreenCheckBox,
                                value: card.complete,
                                onChanged: (_) {
                                  cardsBloc.dispatch(
                                    UpdateCard(
                                      card.copyWith(complete: !card.complete),
                                    ),
                                  );
                                }),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: '${card.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      card.task,
                                      key: ArchSampleKeys.detailsCardItemTask,
                                      style:
                                          Theme.of(context).textTheme.headline,
                                    ),
                                  ),
                                ),
                                Text(
                                  card.note,
                                  key: ArchSampleKeys.detailsCardItemNote,
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.editCardFab,
            tooltip: localizations.editCard,
            child: Icon(Icons.edit),
            onPressed: card == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddEditScreen(
                            key: ArchSampleKeys.editCardScreen,
                            onSave: (task, note) {
                              cardsBloc.dispatch(
                                UpdateCard(
                                  card.copyWith(task: task, note: note),
                                ),
                              );
                            },
                            isEditing: true,
                            card: card,
                          );
                        },
                      ),
                    );
                  },
          ),
        );
      },
    );
  }
}
