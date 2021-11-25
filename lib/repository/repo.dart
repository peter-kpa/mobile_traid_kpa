//import 'dart:ffi';

import 'package:mobile_traid/database/database.dart';
import 'package:mobile_traid/models/entity_model.dart';
import 'package:mobile_traid/models/manager_model.dart';
import 'package:mobile_traid/models/product_model.dart';
import 'package:mobile_traid/models/invoice_model.dart';

class Repo {
  //products
  static List<Product> getGroupsByParentId(String parentId) {
    List<Product> result = [];
    if (Database.productDirectory.containsKey(getCurrentManager()) == false)
      return result;

    for (var element in Database.productDirectory[getCurrentManager()]!) {
      if (element.parentId == parentId) {
        result.add(element);
      }
    }
    return result;
  }

  static Product? getProductById(String id) {
    for (var element in Database.productDirectory[getCurrentManager()]!) {
      if (element.id == id) return element;
    }
  }

  static void saveProducts(List<Product> listProduct) {
    Database.productDirectory[getCurrentManager()!] = listProduct;
  }

  static void clearProducts() {
    Database.productDirectory.remove(getCurrentManager());
  }

  //managers
  static List<Manager> getLocalManagers() {
    return Database.managers;
  }

  static Manager? getCurrentManager() => Database.currentManager;

  static void setCurrentManager(Manager manager) {
    Database.currentManager = manager;
  }

  static void addManager(Manager manager) {
    Database.managers.add(manager);
  }

  static void removeManager(Manager manager) {
    Database.managers.remove(manager);
    //TODO: implement clear db
  }

  //organizations
  static List<Organization> getLocalOrganizations() {
    return Database.organizations!;
  }

  static Organization? getCurrentOrganization() => Database.currentOrganization;

  static Organization? getChosenOrganization() => Database.chosenOrganization;

  static void setCurrentOrganization(Organization organization) {
    Database.currentOrganization = organization;
  }

  static void setChosenOrganization(Organization organization) {
    Database.chosenOrganization = organization;
  }

  // static void addOrganization(Organization organization) {
  //   Database.organizations?.add(organization);
  // }

  // static void removeOrganization(Organization organization) {
  //   Database.organizations?.remove(organization);
  //   //TODO: implement clear db
  // }

  static void clearOrganizations() {
    Database.organizations?.remove(getCurrentOrganization());
  }

  static void saveOrganizations(List<Organization> listOrganization) {
    Database.organizations = listOrganization;
  }

  //warehouse
  static List<Warehouse> getLocalWarehouses() {
    return Database.warehouses;
  }

  static Warehouse? getCurrentWarehouse() => Database.currentWarehouse;

  static Warehouse? getChosenWarehouse() => Database.chosenWarehouse;

  static void setCurrentWarehouse(Warehouse warehouse) {
    Database.currentWarehouse = warehouse;
  }

  static void setChosenWarehouse(Warehouse warehouse) {
    Database.chosenWarehouse = warehouse;
  }

  // static void addWarehouse(Warehouse warehouse) {
  //   Database.warehouses.add(warehouse);
  // }

  // static void removeWarehouse(Warehouse warehouse) {
  //   Database.warehouses.remove(warehouse);
  //   //TODO: implement clear db
  // }

  //invoices
  static List<Invoice> getLocalInvoices() {
    return Database.invoices;
  }

  static Invoice? getCurrentInvoice() => Database.currentInvoice;

  static void setCurrentInvoice(Invoice invoice) {
    Database.currentInvoice = invoice;
  }

  static void addInvoice(Invoice invoice) {
    Database.invoices.add(invoice);
  }

  static void removeInvoice(Invoice invoice) {
    Database.invoices.remove(invoice);
    //TODO: implement clear db
  }

  //product
  static void setChosenProduct(Product product) {
    Database.chosenProduct = product;
  }

  static Product? getChosenProduct() => Database.chosenProduct;
}
