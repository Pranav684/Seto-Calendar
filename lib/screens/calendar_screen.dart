import 'package:calendar/utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../widgets/home_drawer.dart';
import 'event_screen.dart';
import '../model/event.dart';
import '../model/event_data_source.dart';
import '../provider/events_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  @override
  void initState() {
    super.initState();

    // starts timer and generate an in-app alert for upcoming events...
    notifyForEvent();
  }

  notifyForEvent() {
    // ignore: unused_local_variable
    Timer timer;

    // user will get notified before 1 hour about an upcoming event....
    timer = Timer.periodic(
        const Duration(
          hours: 1,
        ), (t) {
      var nowTime = DateTime.now();
      var eventsList = ref.watch(eventsProvider);
      print('in timer');
      for (var i = 0; i < eventsList.length; i++) {
        if (toDate(eventsList[i].from) == toDate(nowTime)) {
          var remainingHour = eventsList[i].from.hour - nowTime.hour;
          var remainingMin = eventsList[i].from.minute - nowTime.minute;
          if (remainingHour < 1 && remainingMin > 1) {
            print('got some to notify');
            showDialog(
              context: context,
              builder: (ctx) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    child: AlertDialog(
                      elevation: 0,
                      contentPadding: const EdgeInsets.all(5),
                      backgroundColor: Theme.of(context).colorScheme.background,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: getScreenSize(context)['width']! * 0.6,
                            child: const Text(
                              'You have an event to attend in next hour',
                              softWrap: true,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.cancel),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Event event = Event(
      id: generateRandomString(10),
      description: '',
      title: '',
      category: 'Work',
      from: DateTime.now(),
      to: DateTime.now(),
    );
    final data = ref.watch(eventsProvider);
    return Scaffold(
      floatingActionButton: _floatingActionButtonForAddEvent(context, event),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Calendar",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfCalendar(
          view: CalendarView.month,
          monthViewSettings: const MonthViewSettings(
              showAgenda: true, agendaStyle: AgendaStyle()),
          firstDayOfWeek: 1,
          dataSource: EventDataSource(data),
          showNavigationArrow: true,
          initialSelectedDate: DateTime.now(),
        ),
      ),
    );
  }

  // Widget to add new events...
  Widget _floatingActionButtonForAddEvent(context, event) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => EventScreen(event: event, isNew: true),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 5, top: 7, bottom: 7),
        width: (getScreenSize(context)['width'])! * 0.28,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Event',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Icon(
              Icons.add,
            ),
          ],
        ),
      ),
    );
  }
}
