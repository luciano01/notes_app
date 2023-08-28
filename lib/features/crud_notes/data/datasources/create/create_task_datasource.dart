import '../../../domain/domain.dart';

abstract class CreateNoteDatasource {
  Future<void> createNote({required NoteEntity noteEntity});
}
