import 'package:flutter/material.dart';
import 'package:cards_app_core/cards_app_core.dart';
import 'package:flutter_cards/models/models.dart' as App;

class DeleteCardSnackBar extends SnackBar {
  final ArchSampleLocalizations localizations;

  DeleteCardSnackBar({
    Key key,
    @required App.Card card,
    @required VoidCallback onUndo,
    @required this.localizations,
  }) : super(
          key: key,
          content: Text(
            localizations.cardDeleted(card.task),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: localizations.undo,
            onPressed: onUndo,
          ),
        );
}
