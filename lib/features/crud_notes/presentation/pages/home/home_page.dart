import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        leading: Icon(
          Icons.account_circle,
          color: Colors.grey.shade900,
        ),
        centerTitle: false,
        title: RichText(
          text: TextSpan(
            text: 'Hello, ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade700,
                ),
            children: [
              TextSpan(
                text: 'Luciano',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
            icon: Icon(
              Icons.more_vert,
              color: Colors.grey.shade900,
            ),
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
      body: ValueListenableBuilder<Box<NoteEntity>>(
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            color: Colors.grey.shade900,
                          ),
                    ),
                  ),
                  Text(
                    'Add a new Note by clicking the button below.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                          color: Colors.grey.shade700,
                        ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.separated(
              itemCount: controller.notesBox.length,
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  thickness: 0.4,
                  color: Colors.grey.shade400,
                ),
              ),
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
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 10,
                          fontStyle: FontStyle.normal,
                          color: Colors.grey.shade700,
                          decoration: note.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                  ),
                  title: Text(
                    note.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          color: Colors.grey.shade900,
                          decoration: note.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                  ),
                  subtitle: note.description.isNotEmpty
                      ? Text(
                          note.description,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.grey.shade600,
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
