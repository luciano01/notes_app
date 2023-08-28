import 'package:hive/hive.dart';
import 'package:notes_app/features/crud_notes/domain/domain.dart';

import '../../data.dart';

class CreateNoteDatasourceImpl implements CreateNoteDatasource {
  final Box _box;

  CreateNoteDatasourceImpl(this._box);

  @override
  Future<void> createNote({required NoteEntity noteEntity}) async {
    await _box.add(noteEntity);
  }
}
