import 'package:flutter/material.dart';
import 'package:minimalist_notes_app/models/note_database.dart';
import 'package:minimalist_notes_app/screens/notes_page.dart';
import 'package:minimalist_notes_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // Initialize Note Isar Database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    MultiProvider(
      providers: [
        // Note database provider
        ChangeNotifierProvider(create: (context) => NoteDatabase()),
        // Theme provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
