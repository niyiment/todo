
import '../../domain/entity/note.dart';
import '../../domain/repository/note_repository.dart';
import '../datasources/local/dao/note_dao.dart';
import '../model/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDao localDataSource;

  NoteRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Note>> getNotes() async {
    final noteModels = await localDataSource.getNotes();
    return noteModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addNote(Note note) async {
    final noteModel = NoteModel.fromEntity(note);
    await localDataSource.addNote(noteModel);
  }

  @override
  Future<void> updateNote(Note note) async {
    final noteModel = NoteModel.fromEntity(note);
    await localDataSource.updateNote(noteModel);
  }

  @override
  Future<void> deleteNote(int id) async {
    await localDataSource.deleteNote(id);
  }


}
