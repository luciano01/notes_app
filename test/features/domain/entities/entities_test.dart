import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_app/features/domain/domain.dart';

class MockNoteEntity extends Mock implements NoteEntity {}

void main() {
  late MockNoteEntity mockNoteEntity;

  setUp(() {
    mockNoteEntity = MockNoteEntity();
  });

  test('The title field should be a String type', () {
    when(() => mockNoteEntity.title).thenAnswer((_) => '');
    expect(mockNoteEntity.title, isA<String>());
  });

  test('The description field should be a String type', () {
    when(() => mockNoteEntity.description).thenAnswer((_) => '');
    expect(mockNoteEntity.description, isA<String>());
  });

  test('The date field should be a DateTime type', () {
    when(() => mockNoteEntity.date).thenAnswer((_) => DateTime.now());
    expect(mockNoteEntity.date, isA<DateTime>());
  });

  test('The isCompleted field should be a bool type', () {
    when(() => mockNoteEntity.isCompleted).thenAnswer((_) => true);
    expect(mockNoteEntity.isCompleted, isA<bool>());
  });
}
