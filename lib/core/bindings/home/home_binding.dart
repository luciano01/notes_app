import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/features/crud_notes/data/data.dart';

import '../../../features/crud_notes/domain/domain.dart';
import '../../../features/crud_notes/presentation/presentation.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    final box = Hive.box<NoteEntity>('notes');

    Get.lazyPut(
      () => HomeState(
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
