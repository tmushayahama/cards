import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cards_app_core/cards_app_core.dart';
import 'package:flutter_cards/models/models.dart' as App;

class CardItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final App.Card card;

  CardItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ArchSampleKeys.cardItem(card.id),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          key: ArchSampleKeys.cardItemCheckbox(card.id),
          value: card.complete,
          onChanged: onCheckboxChanged,
        ),
        title: Hero(
          tag: '${card.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              card.task,
              key: ArchSampleKeys.cardItemTask(card.id),
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        subtitle: card.note.isNotEmpty
            ? Text(
                card.note,
                key: ArchSampleKeys.cardItemNote(card.id),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subhead,
              )
            : null,
      ),
    );
  }
}
