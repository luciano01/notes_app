import 'package:hive/hive.dart';

import '../../../domain/domain.dart';
import '../../data.dart';

class UpdateNoteDatasourceImpl implements UpdateNoteDatasource {
  final Box _box;

  UpdateNoteDatasourceImpl(this._box);

  @override
  Future<void> updateNote({
    required int indexNote,
    required NoteEntity noteEntity,
  }) async {
    await _box.putAt(
      indexNote,
      noteEntity,
    );
  }
}
