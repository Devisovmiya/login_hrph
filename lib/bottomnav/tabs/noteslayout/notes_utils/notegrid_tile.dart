import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_hrph/hivemodels/notes/notesdata.dart';

class NoteGridTile extends ConsumerStatefulWidget {
  final NotesData note;

  const NoteGridTile({super.key, required this.note});

  @override
  ConsumerState<NoteGridTile> createState() => _NoteGridTileState();
}

class _NoteGridTileState extends ConsumerState<NoteGridTile> {
  bool isexpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: const Color.fromARGB(255, 183, 216, 238),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          setState(() {
            isexpanded = !isexpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(widget.note.title ?? '')),
              SizedBox(height: 10),
              Text(
                widget.note.subtitle ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              AnimatedCrossFade(
                firstChild: SizedBox(),
                secondChild: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    widget.note.content ?? " ",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                crossFadeState: isexpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
