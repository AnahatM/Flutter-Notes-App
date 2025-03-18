import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final void Function() updateNote;
  final void Function() deleteNote;

  const NoteSettings({
    super.key,
    required this.updateNote,
    required this.deleteNote,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Edit Button
        GestureDetector(
          onTap: () {
            // Pop dialog on press
            Navigator.pop(context);
            // Update note
            updateNote();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Text(
                "Edit",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
        // Delete Button
        GestureDetector(
          onTap: () {
            // Pop dialog on press
            Navigator.pop(context);
            // Delete note
            deleteNote();
          },
          child: Container(
            height: 20,
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Text(
                "Delete",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
