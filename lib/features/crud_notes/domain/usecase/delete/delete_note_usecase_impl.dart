import '../../domain.dart';

class DeleteNoteUsecaseImpl implements DeleteNoteUsecase {
  final DeleteNoteRepository _deleteNoteRepository;

  DeleteNoteUsecaseImpl(this._deleteNoteRepository);

  @override
  Future<void> deleteNote({required int noteIndex}) async {
    return await _deleteNoteRepository.deleteNote(noteIndex: noteIndex);
  }
}
