import 'package:hive/hive.dart';

part 'note_entity.g.dart';

@HiveType(typeId: 0)
class NoteEntity {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  bool isCompleted;

  NoteEntity({
    required this.title,
    required this.description,
    required this.date,
    required this.isCompleted,
  });

  factory NoteEntity.empty() {
    return NoteEntity(
      title: '',
      description: '',
      isCompleted: false,
      date: DateTime.now(),
    );
  }

  NoteEntity copyWith({
    String? title,
    String? description,
    DateTime? date,
    bool? isCompleted,
  }) {
    return NoteEntity(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
