import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimalist_notes_app/components/my_drawer.dart';
import 'package:minimalist_notes_app/components/note_tile.dart';
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
      // Page Setup
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const MyDrawer(),
      // Create Note Button
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        shape: CircleBorder(),
        elevation: 1,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      // Page Content
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom Title Heading
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "Notes",
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          // Build List of Notes
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                // Get individual note
                final note = currentNotes[index];
                // Return ListTile UI
                return NoteTile(
                  note: note,
                  updateNote: updateNote,
                  deleteNote: deleteNote,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
