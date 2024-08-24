import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entity/note.dart';
import '../provider/note_provider.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Note List'),
      ),
      body: ListView.builder(
        itemCount: noteProvider.notes.length,
        itemBuilder: (context, index) {
          final note = noteProvider.notes[index];
          return ListTile(
            title: Text(
              note.title,
              style: TextStyle(
                decoration: note.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            leading: Checkbox(
              value: note.isCompleted,
              onChanged: (_) {
                noteProvider.toggleComplete(note);
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                noteProvider.removeNoteById(note.id);
                noteProvider.removeItemFromList(index);
              },
            ),
            onTap: () {
              _showNoteDialog(context, noteProvider, note: note);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNoteDialog(context, noteProvider);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showNoteDialog(BuildContext context, NoteProvider noteProvider, {Note? note}) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController titleController = TextEditingController(
      text: note?.title ?? '',
    );

    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: AlertDialog(
              title: Text(note == null ? 'New Task' : 'Edit Task'),
              content: Form(
                key: formKey,
                child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter task title',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Task title cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      final title = titleController.text.trim();
                      if (note == null) {
                        noteProvider.addNewNote(Note(
                          id: DateTime.now().millisecondsSinceEpoch,
                          title: title,
                          isCompleted: false,
                        ));
                         noteProvider.addItemToList(title);
                      } else {
                        noteProvider.updateExistingNote(Note(
                          id: note.id,
                          title: title,
                          isCompleted: note.isCompleted,
                        ));
                        noteProvider.updateItemInList(note, title);
                      }
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(note == null ? 'Add' : 'Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
