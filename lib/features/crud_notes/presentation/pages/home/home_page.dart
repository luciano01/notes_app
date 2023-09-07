import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../presentation.dart';

class HomePage extends GetView<HomeState> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.account_circle),
        title: RichText(
          text: TextSpan(
            text: 'Hello, ',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
              color: Colors.grey.shade600,
            ),
            children: [
              TextSpan(
                text: 'Luciano',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow.shade800,
        child: Icon(
          Icons.add,
          color: Colors.grey.shade50,
        ),
        onPressed: () => Get.toNamed(AppRoutes.registerNote),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ).copyWith(left: 16, right: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.search,
                    cursorColor: Colors.grey.shade900,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      hintText: 'Search your notes',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.filter_list,
                    color: Colors.grey.shade600,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Box<NoteEntity>>(
              valueListenable: controller.notesBox.listenable(),
              builder: (context, box, _) {
                if (box.isEmpty || box.length == 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.emptyList,
                          width: 180,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: Text(
                            'Ooops...Empty list!',
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              color: Colors.grey.shade900,
                            ),
                          ),
                        ),
                        Text(
                          'Add a new Note by clicking the button below.',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            color: Colors.grey.shade600,
                          ),
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
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.yellow.shade800,
                                )
                              : Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.yellow.shade800,
                                ),
                          onPressed: () {
                            controller.updateNote(index, note);
                          },
                        ),
                        trailing: Text(
                          DateFormat.yMd('en_US').format(note.date),
                          style: GoogleFonts.lato(
                            // fontSize: 16,
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                            decoration: note.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        title: Text(
                          note.title,
                          style: GoogleFonts.lato(
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
                                style: GoogleFonts.lato(
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
          ),
        ],
      ),
    );
  }
}
