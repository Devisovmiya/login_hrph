import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:login_hrph/hivemodels/notes/notesdata.dart';
import 'package:login_hrph/riverpod_provider/provider/notes_tab_provider/notesprovider.dart';

class NotesNotifier extends StateNotifier<List<NotesData>> {
  final Ref ref;
  //constructor
  NotesNotifier(this.ref) : super([]) {
    loadNotes();
  }
 //Loasd notes from Hive box
  void loadNotes() {
    final notesBox = ref.read(notesBoxProvider);
    //intial loading
    state = notesBox.values.toList();

    //listen(loading) after data change
    notesBox.watch().listen((_) {
     state = notesBox.values.toList();
    });
  }
//add new note
  void addNote(NotesData note) {
    final notesBox = ref.read(notesBoxProvider);
    notesBox.add(note);
    state = [...state, note];
  }
//delete note
  Future<void> deleteNote(NotesData note) async {
    await note.delete();
    state = state.where((n) => n.key != note.key).toList();
  }
//update existing note
  void updateNote(NotesData oldnote, NotesData newnote, ) {
   final notesBox = ref.read(notesBoxProvider);
   //update fields
   notesBox.put(oldnote.key, newnote);
    //using map to iterate through the list and update the note
    state = notesBox.values.toList();
    
  }
}
