import 'package:mobile_traid/models/manager_model.dart';
import 'package:mobile_traid/models/product_model.dart';
import 'package:mobile_traid/models/entity_model.dart';
import 'package:mobile_traid/models/invoice_model.dart';

class Database {
  static Map<Manager, List<Product>> productDirectory = {};
  static var stocks = [];
  static var route = [];

  static List<Manager> managers = [];
  static Manager? currentManager;

  static Organization? currentOrganization;
  static Organization? chosenOrganization;
  static List<Organization>? organizations = [];

  static List<Warehouse> warehouses = [];
  static Warehouse? currentWarehouse;
  static Warehouse? chosenWarehouse;

  static List<Invoice> invoices = [];
  static Invoice? currentInvoice;
  static Invoice? chosenInvoice;
  static Invoice? newInvoice;

  static List<Product> product = [];
  static Product? chosenProduct;
}


// // Organizations
// // guid
// // name

// // Warehouses
// // guid
// // name

// // ProductDir
// // code
// // name
// // parentCode
// // parentName
// // isGroup
// // price

// // Stocks
// // code - product code
// // name - product name
// // warehouseGuid
// // warehouseName
// // stock

// // Route
// // parthnerCode
// // isClose
// // deliveryDay (number in week)

