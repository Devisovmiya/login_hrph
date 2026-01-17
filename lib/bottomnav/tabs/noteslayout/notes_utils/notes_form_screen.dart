import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_hrph/hivemodels/notes/notesdata.dart';
import 'package:login_hrph/riverpod_provider/provider/notes_tab_provider/notesprovider.dart';

class NotesFormScreen extends ConsumerStatefulWidget {
  final NotesData? note;
  final int? index;
  const NotesFormScreen({super.key, this.note, this.index});

  @override
  ConsumerState<NotesFormScreen> createState() => _NotesFormScreenState();
}

class _NotesFormScreenState extends ConsumerState<NotesFormScreen> {
  //Feilds and controllers go here
  late TextEditingController titleCtrl;
  late TextEditingController subtitleCtrl;
  late TextEditingController contentCtrl;
  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.note?.title ?? '');
    subtitleCtrl = TextEditingController(text: widget.note?.subtitle ?? '');
    contentCtrl = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    subtitleCtrl.dispose();
    contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.note != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Note' : 'Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleCtrl,
              decoration: InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: subtitleCtrl,
              decoration: InputDecoration(
                label: Text('Subtitle'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.top,
                expands: true,
                maxLines: null,
                controller: contentCtrl,
                decoration: InputDecoration(
                  label: Text('Content'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Go Back'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              final title = titleCtrl.text;
              final subtitle = subtitleCtrl.text;
              final content = contentCtrl.text;
              // Action to save the note
              //To Add
              if (!isEdit) {
                ref
                    .read(notesListProvider.notifier)
                    .addNote(
                      NotesData(title: title, subtitle: subtitle, content: content),
                    );
              } else {
                //To Update
                ref
                    .read(notesListProvider.notifier)
                    .updateNote(
                      widget.note!,
                      NotesData(
                        title: titleCtrl.text,
                        subtitle: subtitleCtrl.text,
                        content: contentCtrl.text,
                      ),
                    );
              }
              Navigator.pop(context);
            },
            label: Text(isEdit ? 'Update Note' : 'Add Note'),
          ),
        ],
      ),
        
      
    );
  }
}
