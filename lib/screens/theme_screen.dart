import 'package:flutter/material.dart';
import 'package:calendar/utils.dart' as Utils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/theme_provider.dart';

class ThemeScreen extends ConsumerStatefulWidget {
  const ThemeScreen({super.key});

  @override
  ConsumerState<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends ConsumerState<ThemeScreen> {
  Color selectedThemeElementColor = const Color.fromARGB(255, 251, 195, 191);
  Color notSelectedThemeElementColor = Colors.white;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final listOfThemes = ref.watch(themesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Theme"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (ctx) => const CalendarScreen()));
              },
              child: const Row(
                children: [
                  Icon(Icons.done),
                  SizedBox(width: 5),
                  Text('Done'),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          for (int i = 0; i < listOfThemes.length; i++)
            getThemeElement(i, listOfThemes),
        ],
      ),
    );
  }

  Widget getThemeElement(int index, List<Map> listOftThemes) {
    var themeColorSet = listOftThemes;
    Color backGroundColor = themeColorSet[index]['isSelected']
        ? selectedThemeElementColor
        : notSelectedThemeElementColor;
    return Consumer(
      builder: (ctx, ref, child) {
        return child!;
      },
      child: InkWell(
        onTap: () {
          ref.read(themesProvider.notifier).selectTheme(index);
        },
        child: Container(
          margin: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: backGroundColor,
            boxShadow: const [
              BoxShadow(
                blurStyle: BlurStyle.outer,
                blurRadius: 15,
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(themeColorSet[index]['themeColorName']),
              ),
              Container(
                height: 30,
                margin: const EdgeInsets.all(8),
                width: Utils.getScreenSize(context)['width']! * 0.70,
                decoration: BoxDecoration(
                    color: themeColorSet[index]['primary'],
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
              ),
              Container(
                height: 30,
                margin: const EdgeInsets.all(8),
                width: Utils.getScreenSize(context)['width']! * 0.50,
                decoration: BoxDecoration(
                    color: themeColorSet[index]['primaryLight'],
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
              ),
              Container(
                height: 30,
                margin: const EdgeInsets.all(8),
                width: Utils.getScreenSize(context)['width']! * 0.30,
                decoration: BoxDecoration(
                    color: themeColorSet[index]['primaryDark'],
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
