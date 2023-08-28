import 'package:get/get.dart';

import '../../../domain/domain.dart';

class HomeState extends GetxController {
  final CreateNoteUsecaseImpl _createNoteUsecaseImpl;
  final DeleteNoteUsecaseImpl _deleteNoteUsecaseImpl;
  final UpdateNoteUsecaseImpl _updateNoteUsecaseImpl;

  HomeState(
    this._createNoteUsecaseImpl,
    this._deleteNoteUsecaseImpl,
    this._updateNoteUsecaseImpl,
  );

  final _noteEntity = NoteEntity.empty().obs;
  NoteEntity get noteEntity => _noteEntity.value;

  void setNoteEntity({NoteEntity? noteEntity}) {
    _noteEntity.value = noteEntity ?? NoteEntity.empty();
    refresh();
  }

  void changeTitle(String value) {
    _noteEntity.update((model) {
      model!.title = value;
    });
  }

  void changeDescription(String value) {
    _noteEntity.update((model) {
      model!.description = value;
    });
  }

  void changeDate(DateTime value) {
    _noteEntity.update((model) {
      model!.date = value;
    });
  }

  Future<void> saveNote({int? indexToUpdate}) async {
    try {
      if (indexToUpdate != null) {
        await _updateNoteUsecaseImpl.updateNote(
          indexNote: indexToUpdate,
          noteEntity: noteEntity,
        );
      } else {
        await _createNoteUsecaseImpl.createNote(noteEntity: noteEntity);
      }
      Get.back();
    } catch (_) {
    } finally {}
  }

  Future<void> updateNote(
    int indexNote,
    NoteEntity noteEntity,
  ) async {
    try {
      NoteEntity newNoteEntity = noteEntity.copyWith(
        isCompleted: !noteEntity.isCompleted,
      );
      await _updateNoteUsecaseImpl.updateNote(
        indexNote: indexNote,
        noteEntity: newNoteEntity,
      );
    } catch (_) {
    } finally {}
  }

  Future<void> deleteNote(int indexNote) async {
    try {
      await _deleteNoteUsecaseImpl.deleteNote(noteIndex: indexNote);
    } catch (_) {
    } finally {}
  }
}
