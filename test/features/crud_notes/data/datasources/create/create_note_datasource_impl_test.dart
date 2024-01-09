import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';

import 'package:notes_app/features/crud_notes/data/data.dart';
import 'package:notes_app/features/crud_notes/domain/domain.dart';

class MockBox extends Mock implements Box {}

void main() {
  late MockBox mockBox;
  late CreateNoteDatasourceImpl createNoteDatasourceImpl;

  setUp(() {
    mockBox = MockBox();
    createNoteDatasourceImpl = CreateNoteDatasourceImpl(
      mockBox,
    );
  });

  test('Should create a Note from Hive.', () async {
    final mockEntity = NoteEntity.empty();

    when(() => mockBox.add(mockEntity))
        .thenAnswer((_) async => Future.value(0));

    await createNoteDatasourceImpl.createNote(noteEntity: mockEntity);

    verify(() => mockBox.add(mockEntity));
    verifyNoMoreInteractions(mockBox);
  });
}
