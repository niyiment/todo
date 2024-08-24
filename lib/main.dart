import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/note/data/datasources/local/note_database.dart';

import 'features/note/data/repository/note_repository_impl.dart';
import 'features/note/domain/usecase/index.dart';
import 'features/note/presentation/pages/note_page.dart';
import 'features/note/presentation/provider/note_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorNoteDatabase.databaseBuilder('todo_database.db').build();
  final repository =
      NoteRepositoryImpl(localDataSource: database.noteLocalDataSource);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NoteProvider(
            getNotes: GetNotes(repository),
            addNote: AddNote(repository),
            deleteNote: DeleteNote(repository),
            updateNote: UpdateNote(repository)
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NotePage(),
    );
  }
}