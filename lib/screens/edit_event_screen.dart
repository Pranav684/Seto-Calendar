import 'package:calendar/provider/events_provider.dart';
import 'package:calendar/widgets/edit_event_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditEvents extends ConsumerStatefulWidget {
  const EditEvents({super.key});

  @override
  ConsumerState<EditEvents> createState() => _EditEventsState();
}

class _EditEventsState extends ConsumerState<EditEvents> {
  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Events'),
        // leading: IconButton(
        //   onPressed: () => Navigator.of(context).pop(),
        //   icon: const Icon(Icons.arrow_back),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: events.isNotEmpty
            ? ListView.builder(
                itemCount: events.length,
                itemBuilder: (ctx, i) => Dismissible(
                  background: Container(
                    // margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.only(left: 8),
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(150, 255, 18, 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Delete',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    ref.read(eventsProvider.notifier).deleteEvent(events[i]);
                  },
                  key: ValueKey(events[i].id),
                  child: EditEventElement(event: events[i]),
                ),
              )
            : Center(
                child: Text(
                'Sorry.... nothing to show!',
                style: Theme.of(context).textTheme.titleMedium,
              )),
      ),
    );
  }
}
