


import '../entity/note.dart';
import '../repository/note_repository.dart';

class GetNotes {
  final NoteRepository repository;

  GetNotes(this.repository);

  Future<List<Note>> call() async {
    return await repository.getNotes();
  }
}
