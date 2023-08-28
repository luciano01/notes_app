import 'package:hive/hive.dart';

import '../../data.dart';

class DeleteNoteDatasourceImpl implements DeleteNoteDatasource {
  final Box _box;

  DeleteNoteDatasourceImpl(this._box);

  @override
  Future<void> deleteNote({required int noteIndex}) async {
    await _box.deleteAt(noteIndex);
  }
}
