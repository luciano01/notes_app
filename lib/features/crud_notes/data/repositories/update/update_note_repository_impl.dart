import '../../../domain/domain.dart';
import '../../data.dart';

class UpdateNoteRepositoryImpl implements UpdateNoteRepository {
  final UpdateNoteDatasource _updateNoteDatasource;

  UpdateNoteRepositoryImpl(this._updateNoteDatasource);

  @override
  Future<void> updateNote({
    required int indexNote,
    required NoteEntity noteEntity,
  }) async {
    await _updateNoteDatasource.updateNote(
      indexNote: indexNote,
      noteEntity: noteEntity,
    );
  }
}
