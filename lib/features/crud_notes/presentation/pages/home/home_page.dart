import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../domain/domain.dart';
import '../../presentation.dart';

class HomePage extends GetView<HomeState> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notes'),
        leading: const Icon(Icons.account_circle_outlined),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => saveOrUpdateNote(context),
      ),
      body: ValueListenableBuilder<Box<NoteEntity>>(
        valueListenable: Hive.box<NoteEntity>('notes').listenable(),
        builder: (context, box, _) {
          if (box.isEmpty || box.length == 0) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Empty list!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'You have no Notes at this moment.',
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final note = box.getAt(index) as NoteEntity;
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    controller.deleteNote(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.redAccent,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Successfully deleted Note!',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    onTap: () => saveOrUpdateNote(
                      context,
                      note: note,
                      indexToUpdate: index,
                    ),
                    leading: IconButton(
                      icon: note.isCompleted
                          ? const Icon(
                              Icons.check_circle,
                            )
                          : const Icon(
                              Icons.radio_button_unchecked,
                            ),
                      onPressed: () {
                        controller.updateNote(index, note);
                      },
                    ),
                    title: Text(
                      note.title,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                        decoration: note.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: note.description.isNotEmpty
                        ? Text(
                            note.description,
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.normal,
                              color: Colors.black,
                              decoration: note.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          )
                        : null,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void saveOrUpdateNote(
    BuildContext context, {
    NoteEntity? note,
    int? indexToUpdate,
  }) async {
    controller.setNoteEntity(noteEntity: note);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                  ),
                  onChanged: (value) => controller.changeTitle(value),
                  initialValue: controller.noteEntity.title,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Description',
                  ),
                  onChanged: (value) => controller.changeDescription(value),
                  initialValue: controller.noteEntity.description,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.schedule),
                            onPressed: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                                builder: (context, child) {
                                  return child!;
                                },
                              );
                              if (picked != null) {
                                controller.changeDate(picked);
                              }
                            },
                          ),
                          Obx(
                            () => Text(
                              DateFormat.yMd(
                                'en_US',
                              ).format(
                                controller.noteEntity.date,
                              ),
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      child: const Text('Save'),
                      onPressed: () => controller.saveNote(
                        indexToUpdate: indexToUpdate,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
