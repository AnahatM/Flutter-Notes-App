import 'package:flutter/material.dart';
import 'package:minimalist_notes_app/models/note.dart';
import 'package:minimalist_notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // Text Editing Controller
  final TextEditingController textController = TextEditingController();

  // On app startup, fetch existing notes
  @override
  void initState() {
    super.initState();
    // Initialize Notes on Page Load
    readNotes();
  }

  // Create a Note through Dialog Box Input
  void createNote() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: TextField(controller: textController),
            actions: [
              // Cancel Button
              MaterialButton(
                onPressed: () {
                  // Pop dialog on press
                  Navigator.pop(context);
                  // Clear text field
                  textController.clear();
                },
                child: const Text("Cancel"),
              ),
              // Create Button
              MaterialButton(
                onPressed: () {
                  // Add note to database
                  context.read<NoteDatabase>().addNote(textController.text);
                  // Pop dialog on press
                  Navigator.pop(context);
                  // Clear text field
                  textController.clear();
                },
                child: const Text("Create"),
              ),
            ],
          ),
    );
  }

  // Read Notes
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // Update a Note
  void updateNote(Note note) {
    // Pre-fill text field with existing note text
    textController.text = note.text;
    // Display Dialog Box
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Update Note"),
            content: TextField(controller: textController),
            actions: [
              // Cancel Button
              MaterialButton(
                onPressed: () {
                  // Pop dialog on press
                  Navigator.pop(context);
                  // Clear text field
                  textController.clear();
                },
                child: const Text("Cancel"),
              ),
              // Update Button
              MaterialButton(
                onPressed: () {
                  // Update note in database
                  context.read<NoteDatabase>().updateNote(
                    note.id,
                    textController.text,
                  );
                  // Pop dialog on press
                  Navigator.pop(context);
                  // Clear text field
                  textController.clear();
                },
                child: const Text("Confirm"),
              ),
            ],
          ),
    );
  }

  // Delete a Note
  void deleteNote(int id) {
    // Delete note from database
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // Note Database
    final noteDatabase = context.watch<NoteDatabase>();

    // Current Notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          // Get individual note
          final note = currentNotes[index];
          // Return ListTile UI
          return ListTile(
            title: Text(note.text),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Edit Button
                IconButton(
                  onPressed: () => updateNote(note),
                  icon: Icon(Icons.edit),
                ),
                // Delete Button
                IconButton(
                  onPressed: () => deleteNote(note.id),
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
