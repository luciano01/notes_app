import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../features/crud_notes/data/data.dart';
import '../../../features/crud_notes/domain/domain.dart';
import '../../../features/crud_notes/presentation/presentation.dart';

class RegisterNoteBinding implements Bindings {
  @override
  void dependencies() {
    final box = Hive.box<NoteEntity>('notes');

    Get.lazyPut(
      () => RegisterNoteState(
        CreateNoteUsecaseImpl(
          CreateNoteRepositoryImpl(
            CreateNoteDatasourceImpl(
              box,
            ),
          ),
        ),
        DeleteNoteUsecaseImpl(
          DeleteNoteRepositoryImpl(
            DeleteNoteDatasourceImpl(
              box,
            ),
          ),
        ),
        UpdateNoteUsecaseImpl(
          UpdateNoteRepositoryImpl(
            UpdateNoteDatasourceImpl(
              box,
            ),
          ),
        ),
      ),
    );
  }
}
