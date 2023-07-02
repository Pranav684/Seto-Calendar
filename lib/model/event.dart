// class to store the events data locally while running app

import 'package:flutter/material.dart';

class Event {
  String id;
  String title;
  String category;
  String description;
  DateTime from;
  DateTime to;
  Color backgroundColor;
  bool isAllDay;
  Event({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.from,
    required this.to,
    this.backgroundColor = Colors.green,
    this.isAllDay = false,
  });
}
