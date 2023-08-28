import '../../domain.dart';

abstract class UpdateNoteRepository {
  Future<void> updateNote({
    required int indexNote,
    required NoteEntity noteEntity,
  });
}
