import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_app/features/crud_notes/domain/domain.dart';

class MockDeleteNoteRepository extends Mock implements DeleteNoteRepository {}

void main() {
  late MockDeleteNoteRepository mockDeleteNoteRepository;
  late DeleteNoteUsecaseImpl deleteNoteUsecase;

  setUp(() {
    mockDeleteNoteRepository = MockDeleteNoteRepository();
    deleteNoteUsecase = DeleteNoteUsecaseImpl(
      mockDeleteNoteRepository,
    );
  });

  const noteIndex = 1;

  test('Should delete a Note by Index from the repository', () async {
    when(() => mockDeleteNoteRepository.deleteNote(noteIndex: noteIndex))
        .thenAnswer((_) => Future.value(null));

    await deleteNoteUsecase.deleteNote(noteIndex: noteIndex);

    verify(() => mockDeleteNoteRepository.deleteNote(noteIndex: noteIndex));
    verifyNoMoreInteractions(mockDeleteNoteRepository);
  });
}
