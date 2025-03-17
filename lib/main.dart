import 'package:flutter/material.dart';
import 'package:minimalist_notes_app/models/note_database.dart';
import 'package:minimalist_notes_app/screens/notes_page.dart';
import 'package:provider/provider.dart';

void main() async {
  // Initialize Note Isar Database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteDatabase(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}
