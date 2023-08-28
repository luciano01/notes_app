import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_app/features/crud_notes/domain/domain.dart';

class MockCreateNoteRepository extends Mock implements CreateNoteRepository {}

void main() {
  late MockCreateNoteRepository mockCreateNoteRepository;
  late CreateNoteUsecaseImpl createNoteUsecaseImpl;

  setUp(() {
    mockCreateNoteRepository = MockCreateNoteRepository();
    createNoteUsecaseImpl = CreateNoteUsecaseImpl(
      mockCreateNoteRepository,
    );
  });

  final noteEntity = NoteEntity.empty();

  test('Should create a NoteEnity from the repository', () async {
    when(() => mockCreateNoteRepository.createNote(noteEntity: noteEntity))
        .thenAnswer((_) => Future.value(null));

    await createNoteUsecaseImpl.createNote(noteEntity: noteEntity);

    verify(() => mockCreateNoteRepository.createNote(noteEntity: noteEntity));
    verifyNoMoreInteractions(mockCreateNoteRepository);
  });
}
