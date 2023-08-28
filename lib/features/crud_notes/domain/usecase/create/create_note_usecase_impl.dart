import '../../domain.dart';

class CreateNoteUsecaseImpl implements CreateNoteUsecase {
  final CreateNoteRepository _createNoteRepository;

  CreateNoteUsecaseImpl(this._createNoteRepository);

  @override
  Future<void> createNote({required NoteEntity noteEntity}) async {
    await _createNoteRepository.createNote(noteEntity: noteEntity);
  }
}
