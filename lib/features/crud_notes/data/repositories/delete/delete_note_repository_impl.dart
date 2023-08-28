import '../../../domain/domain.dart';
import '../../data.dart';

class DeleteNoteRepositoryImpl implements DeleteNoteRepository {
  final DeleteNoteDatasource _deleteNoteDatasource;

  DeleteNoteRepositoryImpl(this._deleteNoteDatasource);

  @override
  Future<void> deleteNote({required int noteIndex}) async {
    await _deleteNoteDatasource.deleteNote(noteIndex: noteIndex);
  }
}
