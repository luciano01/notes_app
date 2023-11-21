import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../presentation.dart';

class RegisterNotePage extends GetView<RegisterNoteState> {
  const RegisterNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          controller.indexToUpdate.isNotEmpty ? 'Update Note' : 'New Note',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: Colors.grey.shade900,
              ),
        ),
        actions: [
          Visibility(
            visible: controller.indexToUpdate.isNotEmpty,
            child: IconButton(
              icon: Icon(
                Icons.delete_forever_outlined,
                color: Colors.red.shade500,
              ),
              onPressed: () {
                _alertDialogDeleteNote(
                  context,
                  () {
                    controller.deleteNote(
                      int.parse(controller.indexToUpdate),
                    );
                    Get.back();
                  },
                  () => Get.back(),
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
              Size(Get.width, 48),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.yellow.shade800,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          child: Text(
            'Save',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  color: Colors.grey.shade50,
                ),
          ),
          onPressed: () => controller.saveNote(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title Note',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      color: Colors.grey.shade900,
                    ),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                cursorColor: Colors.yellow.shade900,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      color: Colors.grey.shade900,
                    ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.yellow.shade800,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.yellow.shade900,
                    ),
                  ),
                  hintText: 'Add Note Title...',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        color: Colors.grey.shade700,
                      ),
                ),
                onChanged: (value) => controller.changeTitle(value),
                initialValue: controller.noteEntity.title,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description Note',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: Colors.grey.shade900,
                      ),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.yellow.shade800,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        color: Colors.grey.shade900,
                      ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.yellow.shade800,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.yellow.shade800,
                      ),
                    ),
                    hintText: 'Add Description...',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                          color: Colors.grey.shade700,
                        ),
                  ),
                  onChanged: (value) => controller.changeDescription(value),
                  initialValue: controller.noteEntity.description,
                ),
              ],
            ),
          ),
          Row(
            children: [
              OutlinedButton.icon(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                icon: Icon(
                  Icons.calendar_month,
                  color: Colors.yellow.shade900,
                ),
                label: Obx(
                  () => Text(
                    DateFormat.yMd(
                      'en_US',
                    ).format(
                      controller.noteEntity.date,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                          color: Colors.grey.shade600,
                        ),
                  ),
                ),
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: controller.noteEntity.date,
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
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _alertDialogDeleteNote(
    BuildContext context,
    void Function()? onPressedDelete,
    void Function()? onPressedCancel,
  ) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Note?"),
          content: const Text(
            "This Note will be permanently deleted. Are sure about this?",
          ),
          actions: <Widget>[
            TextButton(
              onPressed: onPressedCancel,
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      color: Colors.grey.shade900,
                    ),
              ),
            ),
            TextButton(
              onPressed: onPressedDelete,
              child: Text(
                'Ok',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      color: Colors.grey.shade900,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
