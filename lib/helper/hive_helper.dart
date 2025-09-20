import 'dart:ui';

import 'package:business_card/model/note.dart';
import 'package:hive_flutter/adapters.dart';

class HiveHelper {
  static const String noteBox = 'noteBox';
  static const noteKey = "noteKey";
  static late List<Note> notes;
  static var box = Hive.box(noteBox);
  static void addNote(
      {required String noteTitle,
      required String noteText,
      required Color color}) async {
    notes.add(Note(noteTitle: noteTitle, noteText: noteText, noteColor: color));
    await box.put(noteKey, notes);
  }

  static void deleteNote(int index) async {
    notes.removeAt(index);
    await box.put(noteKey, notes);
  }

  static void deleteNoteFromFavourite(Note deletedNote) async {
    notes.removeWhere((e) => e == deletedNote);
    await box.put(noteKey, notes);
  }

  static void editNote(int index, Note editedNote) async {
    notes[index] = editedNote;
    await box.put(noteKey, notes);
  }

  static void editNoteFromFavourite(Note oldNote, Note editedNote) async {
    int indexOfNote = notes.indexOf(oldNote);
    notes[indexOfNote] = editedNote;
    await box.put(noteKey, notes);
  }

  static void removeAll() async {
    notes.clear();
    await box.put(noteKey, notes);
  }

  static void setFavourite(int index) async {
    notes[index].isFavourite = true;
    await box.put(noteKey, notes);
  }

  static void getNotes() async {
    notes = await box.get(noteKey) ?? [];
  }
}
