
import 'package:floor/floor.dart';
import '../../../model/note_model.dart';

@dao
abstract class NoteDao {
  @Query('SELECT * FROM NoteModel')
  Future<List<NoteModel>> getNotes();

  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> addNote(NoteModel note);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateNote(NoteModel note);

  @Query('DELETE FROM NoteModel WHERE id = :id')
  Future<void> deleteNote(int id);


}
