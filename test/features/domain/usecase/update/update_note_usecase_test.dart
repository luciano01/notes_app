import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_app/features/crud_notes/domain/domain.dart';

class MockUpdateNoteRepository extends Mock implements UpdateNoteRepository {}

void main() {
  late MockUpdateNoteRepository mockUpdateNoteRepository;
  late UpdateNoteUsecaseImpl updateNoteUsecase;

  setUp(() {
    mockUpdateNoteRepository = MockUpdateNoteRepository();
    updateNoteUsecase = UpdateNoteUsecaseImpl(
      mockUpdateNoteRepository,
    );
  });

  const indexNote = 1;

  final noteEntity = NoteEntity.empty();
  final noteEntityUpdated = NoteEntity.empty();

  test('Should update and return a new value for NoteEntity', () async {
    when(() => mockUpdateNoteRepository.updateNote(
          indexNote: indexNote,
          noteEntity: noteEntity,
        )).thenAnswer((_) async => noteEntityUpdated);

    await updateNoteUsecase.updateNote(
      indexNote: indexNote,
      noteEntity: noteEntity,
    );

    verify(
      () => mockUpdateNoteRepository.updateNote(
        indexNote: indexNote,
        noteEntity: noteEntity,
      ),
    );
    verifyNoMoreInteractions(mockUpdateNoteRepository);
  });
}
