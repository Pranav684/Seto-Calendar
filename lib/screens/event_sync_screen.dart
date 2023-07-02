// import 'package:calendar/model/auth_service.dart';
import 'package:calendar/provider/events_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/event.dart';
import '../model/sync_event_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventSyncScreen extends ConsumerStatefulWidget {
  const EventSyncScreen({super.key});

  @override
  ConsumerState<EventSyncScreen> createState() => _EventSyncScreenState();
}

class _EventSyncScreenState extends ConsumerState<EventSyncScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sync Events'),
        ),
        body: Column(
          children: [
            const Text('Sync your events with Google Calendar'),
            IconButton(
                onPressed: () async {
                  var appointments = ref.read(eventsProvider);
                  syncEventData(appointments);
                  // UserCredential gUserCredential =
                  //     await AuthService().signInWithGoogle();
                  // print(gUserCredential.user!.displayName);
                },
                icon: const Icon(Icons.sync))
          ],
        ));
  }

  void syncEventData(List<Event> appointments) {
    for (var event in appointments) {
      var calendarClient = CalendarClient();
      calendarClient.insert(
          context, event.id, event.title, event.from, event.to);
    }
  }
}
