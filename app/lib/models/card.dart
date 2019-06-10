import 'package:cards_app_core/cards_app_core.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:cards_repository_core/cards_repository_core.dart';

@immutable
class Card extends Equatable {
  final bool complete;
  final String id;
  final String note;
  final String task;

  Card(this.task, {this.complete = false, String note = '', String id})
      : this.note = note ?? '',
        this.id = id ?? Uuid().generateV4(),
        super([complete, id, note, task]);

  Card copyWith({bool complete, String id, String note, String task}) {
    return Card(
      task ?? this.task,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      note: note ?? this.note,
    );
  }

  @override
  String toString() {
    return 'Card { complete: $complete, task: $task, note: $note, id: $id }';
  }

  CardEntity toEntity() {
    return CardEntity(task, id, note, complete);
  }

  static Card fromEntity(CardEntity entity) {
    return Card(
      entity.task,
      complete: entity.complete ?? false,
      note: entity.note,
      id: entity.id ?? Uuid().generateV4(),
    );
  }
}
