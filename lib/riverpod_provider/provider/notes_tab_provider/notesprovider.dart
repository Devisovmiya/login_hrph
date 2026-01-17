import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_hrph/hivemodels/notes/notesdata.dart';
import 'package:login_hrph/riverpod_provider/notifier/notesnotifier.dart';

//Provider for access HiveBox for notesData
final notesBoxProvider = Provider<Box<NotesData>>((ref) {
  return Hive.box('notesbox');
});

//Providers to control notes list
final notesListProvider = StateNotifierProvider<NotesNotifier , List<NotesData>>(
  (ref) {
    return NotesNotifier(ref);
  },
);
