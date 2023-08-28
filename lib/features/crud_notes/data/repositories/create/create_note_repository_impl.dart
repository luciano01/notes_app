import '../../../domain/domain.dart';
import '../../data.dart';

class CreateNoteRepositoryImpl implements CreateNoteRepository {
  final CreateNoteDatasource _createNoteDatasource;

  CreateNoteRepositoryImpl(this._createNoteDatasource);

  @override
  Future<void> createNote({required NoteEntity noteEntity}) async {
    await _createNoteDatasource.createNote(noteEntity: noteEntity);
  }
}
