import '../../../domain/domain.dart';

abstract class UpdateNoteDatasource {
  Future<void> updateNote({
    required int indexNote,
    required NoteEntity noteEntity,
  });
}
