import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cards_app_core/cards_app_core.dart';
import 'package:flutter_cards/blocs/cards/cards.dart';
import 'package:flutter_cards/models/models.dart';
import 'package:flutter_cards/flutter_cards_keys.dart';

class ExtraActions extends StatelessWidget {
  ExtraActions({Key key}) : super(key: ArchSampleKeys.extraActionsButton);

  @override
  Widget build(BuildContext context) {
    final cardsBloc = BlocProvider.of<CardsBloc>(context);
    return BlocBuilder(
      bloc: cardsBloc,
      builder: (BuildContext context, CardsState state) {
        if (state is CardsLoaded) {
          bool allComplete = (cardsBloc.currentState as CardsLoaded)
              .cards
              .every((card) => card.complete);
          return PopupMenuButton<ExtraAction>(
            key: FlutterCardsKeys.extraActionsPopupMenuButton,
            onSelected: (action) {
              switch (action) {
                case ExtraAction.clearCompleted:
                  cardsBloc.dispatch(ClearCompleted());
                  break;
                case ExtraAction.toggleAllComplete:
                  cardsBloc.dispatch(ToggleAll());
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
                  PopupMenuItem<ExtraAction>(
                    key: ArchSampleKeys.toggleAll,
                    value: ExtraAction.toggleAllComplete,
                    child: Text(
                      allComplete
                          ? ArchSampleLocalizations.of(context)
                              .markAllIncomplete
                          : ArchSampleLocalizations.of(context).markAllComplete,
                    ),
                  ),
                  PopupMenuItem<ExtraAction>(
                    key: ArchSampleKeys.clearCompleted,
                    value: ExtraAction.clearCompleted,
                    child: Text(
                      ArchSampleLocalizations.of(context).clearCompleted,
                    ),
                  ),
                ],
          );
        }
        return Container(key: FlutterCardsKeys.extraActionsEmptyContainer);
      },
    );
  }
}
