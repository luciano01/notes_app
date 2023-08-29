import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../core/core.dart';
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
        onPressed: () => Get.toNamed(AppRoutes.registerNote),
      ),
      body: ValueListenableBuilder<Box<NoteEntity>>(
        valueListenable: controller.notesBox.listenable(),
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
              itemCount: controller.notesBox.length,
              itemBuilder: (context, index) {
                final note = box.getAt(index)!;
                return ListTile(
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
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.warning_amber_rounded),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Do you want to delete this Note?',
                                    style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            content: Text(
                              'The task will be permanently deleted from the database.',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () => Get.back(),
                              ),
                              TextButton(
                                child: const Text('Ok'),
                                onPressed: () {
                                  Get.back();
                                  controller.deleteNote(index);
                                },
                              ),
                            ],
                          );
                        },
                      );
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
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.registerNote,
                      parameters: {
                        "index": index.toString(),
                      },
                      arguments: note,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
