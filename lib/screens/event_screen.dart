import 'package:flutter/material.dart';
import '../model/event.dart';
import 'package:calendar/utils.dart' as Utils;
import '../provider/events_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils.dart';

class EventScreen extends ConsumerStatefulWidget {
  const EventScreen({
    super.key,
    required this.event,
    required this.isNew,
  });

  final bool isNew;
  final Event event;

  @override
  ConsumerState<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends ConsumerState<EventScreen> {
  final _formKey = GlobalKey<FormState>();

  // DateTime fromDate = DateTime.now();
  // DateTime toDate = DateTime.now().add(const Duration(hours: 2));

  void _saveData() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.event.from.isAfter(widget.event.to)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('"To Date" must be after the "From Date"')));
      } else {
        if (widget.isNew) {
          ref.read(eventsProvider.notifier).addEvent(widget.event);
        } else {
          ref.read(eventsProvider.notifier).update(widget.event);
        }
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      body: Container(
        // height: 50,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  initialValue: widget.event.title,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    hintText: 'Add a title...',
                  ),
                  onSaved: (newValue) {
                    widget.event.title = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Must not be empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const Align(
                  alignment: Alignment.centerLeft,

// -----------------------Styling needed----------------------------------
                  child: Text('From'),
                ),
                _fromDateWidget(),
                const Align(
                  alignment: Alignment.centerLeft,

// -----------------------Styling needed----------------------------------
                  child: Text('To'),
                ),
                _toDateWidget(),
                SizedBox(
                  height: 60,
                  child: DropdownButtonFormField(
                    hint: const Text('Select a Category'),
                    onChanged: (value) {
                      widget.event.backgroundColor = categories[value];
                      widget.event.category = value.toString();
                    },
                    items: [
                      for (var x in categories.entries)
                        DropdownMenuItem(
                          value: x.key,
                          child: Row(
                            children: [
                              Container(width: 20, height: 20, color: x.value),
                              const SizedBox(width: 20),
                              Text(x.key),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                Align(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _saveData,
                      child: const Text('Save'),
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _toDateWidget() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ListTile(
            title: Text(Utils.toDate(widget.event.to)),
            trailing: const Icon(Icons.arrow_drop_down),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: widget.event.from.add(const Duration(hours: 2)),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              setState(() {
                widget.event.to = date!;
              });
            },
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(Utils.toTime(widget.event.to)),
            trailing: const Icon(Icons.arrow_drop_down),
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(widget.event.to),
              );
              setState(() {
                if (time != null) {
                  widget.event.to = widget.event.to.copyWith(
                    hour: time.hour,
                    minute: time.minute,
                  );
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _fromDateWidget() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ListTile(
            title: Text(Utils.toDate(widget.event.from)),
            trailing: const Icon(Icons.arrow_drop_down),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: widget.event.from,
                firstDate: DateTime(1999),
                lastDate: DateTime(2101),
              );
              setState(() {
                if (date != null) {
                  widget.event.from = date;
                  widget.event.to = widget.event.from.add(
                    const Duration(hours: 2),
                  );
                }
              });
            },
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(Utils.toTime(widget.event.from)),
            trailing: const Icon(Icons.arrow_drop_down),
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(widget.event.from),
              );
              setState(() {
                if (time != null) {
                  widget.event.from = widget.event.from
                      .copyWith(hour: time.hour, minute: time.minute);
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
