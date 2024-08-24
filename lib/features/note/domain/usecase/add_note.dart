

import '../entity/note.dart';
import '../repository/note_repository.dart';

class AddNote {
  final NoteRepository repository;

  AddNote(this.repository);

  Future<void> call(Note note) async {
    await repository.addNote(note);
  }
}
