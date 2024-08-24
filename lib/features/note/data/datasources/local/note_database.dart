import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../model/note_model.dart';
import 'dao/note_dao.dart';

part 'note_database.g.dart'; // generated code

@Database(version: 1, entities: [NoteModel])
abstract class NoteDatabase extends FloorDatabase {
  NoteDao get noteLocalDataSource;
}
