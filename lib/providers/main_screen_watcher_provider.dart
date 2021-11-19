import 'package:flutter/material.dart';

class MainScreenWatcher with ChangeNotifier {
  int bottomNavIndex = 0;
  String title = 'Заказы (накладные)';

  void setBottomNavIndex(int index) {
    bottomNavIndex = index;
    if (index == 0) {
      title = 'Заказы (накладные)';
    }

    if (index == 1) {
      title = 'Возвраты';
    }

    if (index == 2) {
      title = 'Настройки';
    }
    notifyListeners();
  }

  int getBottomNavIndex() {
    return bottomNavIndex;
  }

  String getTitle() {
    return title;
  }
}
