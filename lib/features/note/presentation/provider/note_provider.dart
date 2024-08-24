import 'package:flutter/material.dart';
import 'package:todo/features/note/domain/usecase/index.dart';

import '../../domain/entity/note.dart';



class NoteProvider with ChangeNotifier {
  final GetNotes getNotes;
  final AddNote addNote;
  final DeleteNote deleteNote;
  final UpdateNote updateNote;

  List<Note> _notes = [];
  List<Note> get notes => _notes;


  NoteProvider({
    required this.getNotes,
    required this.addNote,
    required this.deleteNote,
    required this.updateNote
  }) {
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    _notes = await getNotes();
    notifyListeners();
  }

  Future<void> addNewNote(Note note) async {
    await addNote(note);
    _notes.add(note);
    notifyListeners();
  }

  void addItemToList(String title) {
    final note = Note(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      isCompleted: false,
    );
    _notes.add(note);
  }

  void updateItemInList(Note note, String newTitle) {
    final index = _notes.indexOf(note);
    if (index != -1) {
      _notes[index] = Note(
        id: note.id,
        title: newTitle,
        isCompleted: note.isCompleted,
      );
      notifyListeners();
    }
  }

  void removeItemFromList(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }

  Future<void> updateExistingNote(Note note) async {
    await updateNote(note);
    fetchNotes();
  }

  Future<void> removeNoteById(int id) async {
    await deleteNote(id);
    fetchNotes();
  }

  Future<void> toggleComplete(Note note) async {
    final updatedNote = Note(
      id: note.id,
      title: note.title,
      isCompleted: !note.isCompleted,
    );
    await updateNote(updatedNote);
    fetchNotes();
  }



}
