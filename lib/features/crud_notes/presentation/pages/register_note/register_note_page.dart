import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../presentation.dart';

class RegisterNotePage extends GetView<RegisterNoteState> {
  const RegisterNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            controller.indexToUpdate.isNotEmpty ? 'Update Note' : 'Add Note'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () => controller.saveNote(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Visibility(
              visible: controller.indexToUpdate.isNotEmpty,
              child: IconButton(
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
                              controller.deleteNote(
                                int.parse(controller.indexToUpdate),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        children: [
          const SizedBox(height: 16),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              hintText: 'Title',
            ),
            onChanged: (value) => controller.changeTitle(value),
            initialValue: controller.noteEntity.title,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: TextFormField(
              keyboardType: TextInputType.text,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                hintText: 'Description',
              ),
              onChanged: (value) => controller.changeDescription(value),
              initialValue: controller.noteEntity.description,
            ),
          ),
          Row(
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
        ],
      ),
    );
  }
}
