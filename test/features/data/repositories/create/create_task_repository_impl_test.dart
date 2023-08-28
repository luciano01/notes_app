import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_app/features/crud_notes/data/data.dart';
import 'package:notes_app/features/crud_notes/domain/domain.dart';

class MockCreateNoteDatasource extends Mock implements CreateNoteDatasource {}

void main() {
  late MockCreateNoteDatasource mockCreateNoteDatasource;
  late CreateNoteRepositoryImpl createNoteRepositoryImpl;

  setUp(() {
    mockCreateNoteDatasource = MockCreateNoteDatasource();
    createNoteRepositoryImpl = CreateNoteRepositoryImpl(
      mockCreateNoteDatasource,
    );
  });

  final noteEntity = NoteEntity.empty();

  test('Should create a NoteEntity from the Datasource', () async {
    when(() => mockCreateNoteDatasource.createNote(noteEntity: noteEntity))
        .thenAnswer((_) async => Future.value(null));

    await createNoteRepositoryImpl.createNote(noteEntity: noteEntity);

    verify(() => mockCreateNoteDatasource.createNote(noteEntity: noteEntity));
  });
}
