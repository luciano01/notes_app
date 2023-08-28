import '../../domain.dart';

abstract class UpdateNoteUsecase {
  Future<void> updateNote({
    required int indexNote,
    required NoteEntity noteEntity,
  });
}
