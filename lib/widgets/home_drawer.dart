import 'package:flutter/material.dart';
import '../screens/edit_event_screen.dart';
import '../screens/event_sync_screen.dart';
import '../screens/theme_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 100,
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text('Settings',
                    style: Theme.of(context).textTheme.titleLarge)),
          ),
          const SizedBox(height: 10),
          InkWell(
            child: ListTile(
              tileColor: Theme.of(context).colorScheme.primary,
              leading: const Icon(Icons.event_available),
              title: const Text('Events'),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const EditEvents(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: ListTile(
              tileColor: Theme.of(context).colorScheme.primary,
              leading: const Icon(Icons.event_available),
              title: const Text('Sync Data'),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const EventSyncScreen(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: ListTile(
              tileColor: Theme.of(context).colorScheme.primary,
              leading: const Icon(Icons.color_lens),
              title: const Text('Themes'),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ThemeScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
