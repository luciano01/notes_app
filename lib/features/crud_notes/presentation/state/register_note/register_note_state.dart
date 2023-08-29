import 'package:get/get.dart';

import '../../../domain/domain.dart';

class RegisterNoteState extends GetxController {
  final CreateNoteUsecaseImpl _createNoteUsecaseImpl;
  final DeleteNoteUsecaseImpl _deleteNoteUsecaseImpl;
  final UpdateNoteUsecaseImpl _updateNoteUsecaseImpl;

  RegisterNoteState(
    this._createNoteUsecaseImpl,
    this._deleteNoteUsecaseImpl,
    this._updateNoteUsecaseImpl,
  );

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  final _noteEntity = NoteEntity.empty().obs;
  NoteEntity get noteEntity => _noteEntity.value;

  final _indexToUpdate = ''.obs;
  String get indexToUpdate => _indexToUpdate.value;

  void _init() {
    if (Get.parameters.containsKey('index') && Get.arguments != null) {
      _indexToUpdate.value = Get.parameters['index']!;
      _noteEntity.value = Get.arguments;
      refresh();
    }
  }

  /// Change the Title value
  void changeTitle(String value) {
    _noteEntity.update((model) {
      model!.title = value;
    });
  }

  /// Change the Description value
  void changeDescription(String value) {
    _noteEntity.update((model) {
      model!.description = value;
    });
  }

  /// Change the Date value
  void changeDate(DateTime value) {
    _noteEntity.update((model) {
      model!.date = value;
    });
  }

  /// Save or Update a Note
  Future<void> saveNote() async {
    try {
      if (indexToUpdate.isNotEmpty) {
        await _updateNoteUsecaseImpl.updateNote(
          indexNote: int.parse(indexToUpdate),
          noteEntity: noteEntity,
        );
      } else {
        await _createNoteUsecaseImpl.createNote(
          noteEntity: noteEntity,
        );
      }
      Get.back();
    } catch (_) {
    } finally {}
  }

  /// Save or Delete a Note
  Future<void> deleteNote(int noteIndex) async {
    try {
      await _deleteNoteUsecaseImpl.deleteNote(
        noteIndex: noteIndex,
      );
      Get.back();
    } catch (_) {
    } finally {}
  }
}
