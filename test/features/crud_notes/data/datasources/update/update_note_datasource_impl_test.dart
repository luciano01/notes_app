import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';

import 'package:notes_app/features/crud_notes/data/data.dart';
import 'package:notes_app/features/crud_notes/domain/domain.dart';

class MockBox extends Mock implements Box {}

void main() {
  late MockBox mockBox;
  late UpdateNoteDatasourceImpl updateNoteDatasourceImpl;

  setUp(() {
    mockBox = MockBox();
    updateNoteDatasourceImpl = UpdateNoteDatasourceImpl(
      mockBox,
    );
  });

  test('Should update a Note from Hive.', () async {
    const mockIndex = 0;
    final mockEntity = NoteEntity.empty();

    when(() => mockBox.putAt(mockIndex, mockEntity))
        .thenAnswer((_) async => Future.value());

    await updateNoteDatasourceImpl.updateNote(
      indexNote: mockIndex,
      noteEntity: mockEntity,
    );

    verify(() => mockBox.putAt(mockIndex, mockEntity));
    verifyNoMoreInteractions(mockBox);
  });
}
