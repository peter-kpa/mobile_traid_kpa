import 'package:flutter/material.dart';
import 'package:mobile_traid/models/manager_model.dart';
import 'package:mobile_traid/repository/repo.dart';

class ManagerWatcher with ChangeNotifier {
  List<Manager> localManagers = [];

  void updateLocalManagers() {
    localManagers = Repo.getLocalManagers();
    notifyListeners();
  }

  void addNewManager(Manager manager) {
    Repo.addManager(manager);
    updateLocalManagers();
    // notifyListeners();
  }

  void removeManager(Manager manager) {
    Repo.removeManager(manager);
    updateLocalManagers();
  }

  void setCurrentManager(Manager manager) {
    Repo.setCurrentManager(manager);
  }
}
