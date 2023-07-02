import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/theme_data.dart';
import 'package:flutter/material.dart';

class ThemesNotifier extends StateNotifier<List<Map>> {
  ThemesNotifier() : super(customizedThemeColor);

  void selectTheme(int index) {
    List<Map> newState = state;
    for (int i = 0; i < newState.length; i++) {
      if (i == index) {
        newState[i]['isSelected'] = true;
      } else {
        newState[i]['isSelected'] = false;
      }
    }
    state = newState;
    state = [...state];
  }

  Map getSelectedTheme() {
    int index = 0;
    for (int i = 0; i < state.length; i++) {
      if (state[i]['isSelected']) {
        index = i;
      }
    }
    return state[index];
  }
}

final themesProvider =
    StateNotifierProvider<ThemesNotifier, List<Map>>((ref) => ThemesNotifier());
