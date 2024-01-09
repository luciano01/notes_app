import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_app/features/crud_notes/data/data.dart';

class MockBox extends Mock implements Box {}

void main() {
  late MockBox mockBox;
  late DeleteNoteDatasourceImpl deleteNoteDatasourceImpl;

  setUp(() {
    mockBox = MockBox();
    deleteNoteDatasourceImpl = DeleteNoteDatasourceImpl(
      mockBox,
    );
  });

  test('Should delete a Note by index fro Hive.', () async {
    const mockIndex = 0;

    when(() => mockBox.deleteAt(mockIndex))
        .thenAnswer((_) async => Future.value());

    await deleteNoteDatasourceImpl.deleteNote(noteIndex: mockIndex);

    verify(() => mockBox.deleteAt(mockIndex));
    verifyNoMoreInteractions(mockBox);
  });
}
