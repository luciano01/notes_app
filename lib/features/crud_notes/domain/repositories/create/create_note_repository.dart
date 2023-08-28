import '../../domain.dart';

abstract class CreateNoteRepository {
  Future<void> createNote({required NoteEntity noteEntity});
}
