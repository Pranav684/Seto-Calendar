import 'package:calendar/model/event.dart';
import 'package:calendar/screens/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:calendar/utils.dart' as Utils;

class EditEventElement extends StatefulWidget {
  const EditEventElement({super.key, required this.event});

  final Event event;

  @override
  State<EditEventElement> createState() => _EditEventElementState();
}

class _EditEventElementState extends State<EditEventElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.event.backgroundColor.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Theme.of(context).disabledColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.event.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              FilledButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => EventScreen(
                          event: widget.event,
                          isNew: false,
                        ),
                      ),
                    );
                  },
                  child: const Text('Edit'))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('From:  ${Utils.toDate(widget.event.from)}'),
              const SizedBox(
                width: 20,
              ),
              Text('To:  ${Utils.toDate(widget.event.to)}'),
            ],
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Caterogy:  ${widget.event.category}'))
        ],
      ),
    );
  }
}
