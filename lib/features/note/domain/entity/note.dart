

import 'package:floor/floor.dart';

class Note {
  @primaryKey
  final int id;
  final String title;
  final bool isCompleted;

  Note({
    required this.id,
    required this.title,
    required this.isCompleted,
  });
}
