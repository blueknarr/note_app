import 'package:note_app/domain/repository/note_repository.dart';

import '../model/note.dart';

class GetNote {
  final NoteRepository repository;

  GetNote(this.repository);

  Future<Note?> getNote(int id) async {
    return await repository.getNoteById(id);
  }
}
