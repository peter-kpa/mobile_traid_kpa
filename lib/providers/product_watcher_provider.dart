import 'package:flutter/material.dart';
import 'package:mobile_traid/models/product_model.dart';
import 'package:mobile_traid/repository/repo.dart';

class ProductWatcher with ChangeNotifier {
  Product? product;
  Product? rootGroup;
  String? title = 'Номенклатура';
  String parentId = '0';
  List<Product> products = Repo.getGroupsByParentId('0');

  void setTitle(String newTitle) {
    // print(newTitle);
    title = newTitle;
    notifyListeners();
  }

  void onTapHandler(Product product) {
    if (!product.isGroup) {
      // title = product.name;
      setTitle(product.name);
      notifyListeners();
      return;
    }

    rootGroup = product;
    setTitle(rootGroup?.name ?? 'Номенклатура');
    parentId = product.id;
    products = Repo.getGroupsByParentId(parentId);
    notifyListeners();
  }

  void up() {
    parentId = rootGroup?.parentId ?? '0';
    rootGroup = parentId == '0' ? null : Repo.getProductById(parentId);
    setTitle(rootGroup?.name ?? 'Номенклатура');
    products = Repo.getGroupsByParentId(parentId);
    notifyListeners();
  }
}
