import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/event.dart';

class EventsNotifier extends StateNotifier<List<Event>> {
  EventsNotifier() : super([]);

  void addEvent(Event newEvent) {
    state = [...state, newEvent];
  }

  void deleteEvent(Event selectedEvent) {
    state = state.where((element) => selectedEvent.id != element.id).toList();
  }

  void update(Event selectedEvent) {
    for (var element in state) {
      if (element.id == selectedEvent.id) element = selectedEvent;
    }
    state = [...state];
  }
}

final eventsProvider = StateNotifierProvider<EventsNotifier, List<Event>>(
    (ref) => EventsNotifier());
