import 'package:get/get.dart';

import '../../../domain/domain.dart';

class HomeState extends GetxController {
  final DeleteNoteUsecaseImpl _deleteNoteUsecaseImpl;
  final UpdateNoteUsecaseImpl _updateNoteUsecaseImpl;

  HomeState(
    this._deleteNoteUsecaseImpl,
    this._updateNoteUsecaseImpl,
  );

  /// Update Note by index passing new value
  Future<void> updateNote(
    int indexNote,
    NoteEntity noteEntity,
  ) async {
    try {
      final noteUpdated = noteEntity.copyWith(
        isCompleted: !noteEntity.isCompleted,
      );
      await _updateNoteUsecaseImpl.updateNote(
        indexNote: indexNote,
        noteEntity: noteUpdated,
      );
    } catch (_) {
    } finally {}
  }

  /// Delete Note by index
  Future<void> deleteNote(int indexNote) async {
    try {
      await _deleteNoteUsecaseImpl.deleteNote(
        noteIndex: indexNote,
      );
    } catch (_) {
    } finally {}
  }
}
