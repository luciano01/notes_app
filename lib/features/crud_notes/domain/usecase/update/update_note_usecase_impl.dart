import '../../domain.dart';

class UpdateNoteUsecaseImpl implements UpdateNoteUsecase {
  final UpdateNoteRepository _updateNoteRepository;

  UpdateNoteUsecaseImpl(this._updateNoteRepository);

  @override
  Future<void> updateNote({
    required int indexNote,
    required NoteEntity noteEntity,
  }) async {
    await _updateNoteRepository.updateNote(
      indexNote: indexNote,
      noteEntity: noteEntity,
    );
  }
}
