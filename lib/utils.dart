import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

String toDate(DateTime dateTime) {
  final date = DateFormat.yMMMEd().format(dateTime);
  return date;
}

String toTime(DateTime dateTime) {
  final time = DateFormat.Hm().format(dateTime);
  return time;
}

String generateRandomString(int lengthOfString) {
  final random = Random();
  const allChars =
      'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
  // below statement will generate a random string of length using the characters
  // and length provided to it
  final randomString = List.generate(
          lengthOfString, (index) => allChars[random.nextInt(allChars.length)])
      .join();
  return randomString; // return the generated string
}

// colorPicker(pickerColor,changeColor,ctx){
//   return showDialog(
//   context: ,
//   builder: (context) => AlertDialog(
//       title: const Text('Pick a color!'),
//       content: SingleChildScrollView(
//         child: ColorPicker(
//           pickerColor: pickerColor,
//           onColorChanged: changeColor,
//         ),
//         // Use Material color picker:
//         //
//         // child: MaterialPicker(
//         //   pickerColor: pickerColor,
//         //   onColorChanged: changeColor,
//         //   showLabel: true, // only on portrait mode
//         // ),
//         //
//         // Use Block color picker:
//         //
//         // child: BlockPicker(
//         //   pickerColor: currentColor,
//         //   onColorChanged: changeColor,
//         // ),
//         //
//         // child: MultipleChoiceBlockPicker(
//         //   pickerColors: currentColors,
//         //   onColorsChanged: changeColors,
//         // ),
//       ),
//       actions: <Widget>[
//         ElevatedButton(
//           child: const Text('Got it'),
//           onPressed: () {
//             setState(() => currentColor = pickerColor);
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     ), builder: (context) {

//   },
//   );

// }

Map<String, double> getScreenSize(context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return {
    'width': width,
    'height': height,
  };
}

Map categories = {
  'Important': Colors.red,
  'Work': Colors.blue,
  'Family': Colors.yellow,
  'Health': Colors.green,
  'Fun-Tastic': Colors.purple,
};

Map selectedAppTheme = {};
