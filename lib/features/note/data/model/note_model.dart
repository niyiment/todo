
import 'package:floor/floor.dart';
import '../../domain/entity/note.dart';

@entity
class NoteModel extends Note {
  NoteModel({
    required super.id,
    required super.title,
    required super.isCompleted,
  });

  factory NoteModel.fromEntity(Note note) {
    return NoteModel(id: note.id, title: note.title, isCompleted: note.isCompleted);
  }

  Note toEntity() {
    return Note(
      id: id,
      title: title,
      isCompleted: isCompleted,
    );
  }
}
