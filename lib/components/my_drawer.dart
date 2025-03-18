import 'package:flutter/material.dart';
import 'package:minimalist_notes_app/components/drawer_tile.dart';
import 'package:minimalist_notes_app/screens/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // Header
          DrawerHeader(child: Icon(Icons.edit)),

          // Notes Page Tile
          DrawerTile(
            title: "Notes",
            leading: Icon(
              Icons.book,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            onTap: () => Navigator.pop(context),
          ),

          // Settings Page Tile
          DrawerTile(
            title: "Settings",
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            onTap: () {
              // Pop Drawer
              Navigator.pop(context);
              // Navigate to Settings Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
