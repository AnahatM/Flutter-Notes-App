import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:minimalist_notes_app/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // Initialize Database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  // List of Notes
  final List<Note> currentNotes = [];

  // Create note and save to Database
  Future<void> addNote(String textFromUser) async {
    // Create new note object
    final newNote = Note()..text = textFromUser;
    // Save to database
    await isar.writeTxn(() => isar.notes.put(newNote));
    // Re-read notes from database
    await fetchNotes();
  }

  // Read notes from Database
  Future<void> fetchNotes() async {
    // Fetch all notes from database
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    // Update current notes list
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    // Notify listeners
    notifyListeners();
  }

  // Update note in Database
  Future<void> updateNote(int id, String newText) async {
    // Find note by id
    final existingNote = await isar.notes.get(id);

    if (existingNote != null) {
      // Update note text
      existingNote.text = newText;
      // Save to database
      await isar.writeTxn(() => isar.notes.put(existingNote));
      // Re-read notes from database
      await fetchNotes();
    }
  }

  // Delete note from Database
  Future<void> deleteNote(int id) async {
    // Delete note from database
    await isar.writeTxn(() => isar.notes.delete(id));
    // Re-read notes from database
    await fetchNotes();
  }
}
