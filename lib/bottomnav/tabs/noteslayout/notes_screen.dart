import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:login_hrph/riverpod_provider/provider/notes_tab_provider/notesprovider.dart';
import 'package:login_hrph/utilis/responsive.dart';

import 'notes_utils/notegrid_tile.dart';
import 'notes_utils/notes_form_screen.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notebox = ref.watch(notesListProvider);
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        elevation: 25,
        centerTitle: true,

        leading: Icon(Icons.timeline_outlined),
        title: Text('Notes'),
      ),
      body: GridView.builder(
        itemCount: notebox.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: calculateGridCount(context),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 2,
        ),
        itemBuilder: (context, index) {
          return Slidable(
            startActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NotesFormScreen(
                            note: notebox[index],
                            index: index,
                          );
                        },
                      ),
                    );
                  },
                  icon: Icons.edit_note_outlined,
                  backgroundColor: const Color.fromARGB(255, 100, 255, 139),
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),
             endActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) {
                            ref
                                .read(notesListProvider.notifier)
                                .deleteNote(notebox[index]);
                          },
                          icon: Icons.delete_outline_outlined,
                          backgroundColor: const Color.fromARGB(
                            255,
                            253,
                            67,
                            67,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ],
                    ),
            child: NoteGridTile(note: notebox[index]),
          );
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 114, 141, 201),
          borderRadius: BorderRadius.circular(10),
        ),
        // add a new note
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
            // Action to add a new note

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotesFormScreen()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.add), SizedBox(width: 2), Text('Add Note')],
            ),
          ),
        ),
      ),
    );
  }
}
