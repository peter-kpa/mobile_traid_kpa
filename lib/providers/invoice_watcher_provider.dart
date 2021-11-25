import 'package:flutter/material.dart';
import 'package:mobile_traid/models/invoice_model.dart';
import 'package:mobile_traid/models/entity_model.dart';
import 'package:mobile_traid/models/manager_model.dart';
import 'package:mobile_traid/repository/repo.dart';

class InvoiceWatcher with ChangeNotifier {
  Manager? manager;
  Organization? organization;
  String docTypeName = 'realization';
  TradePoint? tradePoint;
  Warehouse? wareHouse;
  double sum = 0;
  TabularSection? productList;

  List<Invoice> localInvoices = [];

  void updateLocalInvoices() {
    localInvoices = Repo.getLocalInvoices();
    notifyListeners();
  }

  void addNewInvoice(Invoice invoice) {
    Repo.addInvoice(invoice);
    updateLocalInvoices();
    notifyListeners();
  }

  void removeInvoice(Invoice invoice) {
    Repo.removeInvoice(invoice);
    updateLocalInvoices();
  }

  void setCurrentInvoice(Invoice invoice) {
    Repo.setCurrentInvoice(invoice);
  }

  Invoice? getCurrentInvoice() {
    return Repo.getCurrentInvoice();
  }
}

//   void up() {
//     // parentId = rootGroup?.parentId ?? '0';
//     // rootGroup = parentId == '0' ? null : Repo.getProductById(parentId);
//     // setTitle(rootGroup?.name ?? 'Номенклатура');
//     // products = Repo.getGroupsByParentId(parentId);
//     // notifyListeners();
//   }
// }
