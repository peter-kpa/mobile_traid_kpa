import 'package:flutter/material.dart';
import 'package:mobile_traid/models/entity_model.dart';
import 'package:mobile_traid/repository/repo.dart';

class WarehouseWatcher with ChangeNotifier {
  List<Warehouse> localWarehouses = [];

  void updateLocalWarehouses() {
    localWarehouses = Repo.getLocalWarehouses();
    notifyListeners();
  }

  // void addNewWarehouse(Warehouse warehouse) {
  //   Repo.addWarehouse(warehouse);
  //   updateLocalWarehouses();
  //   // notifyListeners();
  // }

  // void removeWarehouse(Warehouse warehouse) {
  //   Repo.removeWarehouse(warehouse);
  //   updateLocalWarehouses();
  // }

  void setCurrentWarehouse(Warehouse warehouse) {
    Repo.setCurrentWarehouse(warehouse);
  }

  void setChosenWarehouse(Warehouse warehouse) {
    Repo.setChosenWarehouse(warehouse);
  }
}
