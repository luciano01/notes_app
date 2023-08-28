import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_app/features/crud_notes/data/data.dart';

class MockDeleteNoteDatasource extends Mock implements DeleteNoteDatasource {}

void main() {
  late MockDeleteNoteDatasource mockDeleteNoteDatasource;
  late DeleteNoteRepositoryImpl deleteNoteRepositoryImpl;

  setUp(() {
    mockDeleteNoteDatasource = MockDeleteNoteDatasource();
    deleteNoteRepositoryImpl = DeleteNoteRepositoryImpl(
      mockDeleteNoteDatasource,
    );
  });

  const noteIndex = 1;

  test('Should delete the NoteEntity by index', () async {
    when(() => mockDeleteNoteDatasource.deleteNote(noteIndex: noteIndex))
        .thenAnswer((_) => Future.value(null));

    await deleteNoteRepositoryImpl.deleteNote(noteIndex: noteIndex);

    verify(() => mockDeleteNoteDatasource.deleteNote(noteIndex: noteIndex));
  });
}
