import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_app/features/crud_notes/data/data.dart';
import 'package:notes_app/features/crud_notes/domain/domain.dart';

class MockUpdateNoteDatasource extends Mock implements UpdateNoteDatasource {}

void main() {
  late MockUpdateNoteDatasource mockUpdateNoteDatasource;
  late UpdateNoteRepositoryImpl updateNoteRepositoryImpl;

  setUp(() {
    mockUpdateNoteDatasource = MockUpdateNoteDatasource();
    updateNoteRepositoryImpl = UpdateNoteRepositoryImpl(
      mockUpdateNoteDatasource,
    );
  });

  final noteEntity = NoteEntity.empty();

  const indexNote = 1;

  test('Should update a NoteEntity by index and NoteEntity', () async {
    when(() => mockUpdateNoteDatasource.updateNote(
          indexNote: indexNote,
          noteEntity: noteEntity,
        )).thenAnswer((_) async => Future.value(null));

    await updateNoteRepositoryImpl.updateNote(
      indexNote: indexNote,
      noteEntity: noteEntity,
    );

    verify(() => mockUpdateNoteDatasource.updateNote(
          indexNote: indexNote,
          noteEntity: noteEntity,
        ));
  });
}
