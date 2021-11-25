//import 'package:flutter/material.dart';
import 'package:mobile_traid/models/entity_model.dart';
import 'package:mobile_traid/models/manager_model.dart';

class Invoice implements Document {
  @override
  String internalDocumentNumber = ''; //Uuid().v1().toString();

  @override
  String? externalDocumentNumber = '';

  @override
  DateTime documentDate = DateTime.now();

  @override
  bool posted = false;

  @override
  bool deletionMark = false;

  Manager? manager;
  Organization? organization;
  String docTypeName = 'realization';
  TradePoint? tradePoint;
  Warehouse? wareHouse;
  double sum = 0;
  TabularSection? productList;

  Invoice({
    required this.internalDocumentNumber,
    this.externalDocumentNumber,
    required this.documentDate,
    required this.posted,
    required this.deletionMark,
    required this.manager,
    required this.organization,
    required this.docTypeName,
    required this.tradePoint,
    required this.wareHouse,
    required this.sum,
    GoodsTabularSection? this.productList,
  });

  // factory Invoice.fromJson(Map<String, dynamic> json) {
  //   return Invoice(docTypeName: 'realization',
  //     documentNumber: )
  // }
}
