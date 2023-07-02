// using this method to sync the data with google calendar but it is not working.

import 'dart:developer';
// import 'package:flutter/material.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarClient {
  var _credentials;

  static const _scopes = [CalendarApi.calendarEventsScope];

  insert(context, id, title, startTime, endTime) {
    _credentials = ClientId(
        "509399802332-epn44d7r01oo26gtv8kl5uf0704hqc7i.apps.googleusercontent.com",
        "");

    if (_credentials != null) {
      clientViaUserConsent(_credentials, _scopes, prompt)
          .then((AuthClient client) {
        var calendar = CalendarApi(client);

        String calendarId = id;
        Event event = Event(); // Create object of event

        event.summary = title;
        //event.description="OPTIMEET TEST 1";

        DateTime startDateTime = startTime;
        EventDateTime start = EventDateTime();
        start.dateTime = startDateTime;
        start.timeZone = "GMT+05:00";

        event.start = start;

        DateTime endDateTime = endTime;
        EventDateTime end = EventDateTime();
        end.timeZone = "GMT+05:00";
        end.dateTime = endDateTime;

        event.end = end;

        try {
          calendar.events.insert(event, calendarId).then((value) {
            print("ADDEDDD_________________${value.status}");
            if (value.status == "confirmed") {
              // Dialogs().displayToast(
              //     context, "Event added in google calendar", 0);
              log('Event added in google calendar');
            } else {
              log("Unable to add event in google calendar");
              // Dialogs().displayToast(
              //     context, "Unable to add event in google calendar", 0);
            }
          });
        } catch (e) {
          log('Error creating event $e');
          // Dialogs().displayToast(context, e, 0);
        } // function to insert event
        // incase of any confusion i will recommed to go to implementation of calendar/v3.dart
        // and read comments of their codez
      });
    }
  }

  void prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
