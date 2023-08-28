import '../../domain.dart';

abstract class CreateNoteUsecase {
  Future<void> createNote({required NoteEntity noteEntity});
}
