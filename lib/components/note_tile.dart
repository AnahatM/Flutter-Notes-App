import 'package:flutter/material.dart';
import 'package:minimalist_notes_app/components/note_settings.dart';
import 'package:minimalist_notes_app/models/note.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final void Function(Note note) updateNote;
  final void Function(int id) deleteNote;

  const NoteTile({
    super.key,
    required this.note,
    required this.updateNote,
    required this.deleteNote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 4.0),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: ListTile(
        title: Text(
          note.text,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        trailing: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              onPressed:
                  () => showPopover(
                    width: 100,
                    height: 85,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    context: context,
                    bodyBuilder:
                        (context) => NoteSettings(
                          updateNote: () => updateNote(note),
                          deleteNote: () => deleteNote(note.id),
                        ),
                  ),
            );
          },
        ),
      ),
    );
  }
}
