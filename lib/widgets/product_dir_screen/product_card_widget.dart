import 'package:flutter/material.dart';
import 'package:mobile_traid/models/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  // final String title;

  const ProductCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          product.name,
          style: const TextStyle(fontSize: 17),
        ),
      ),
      body: ElevatedButton(
        child: const Text('Ok'),
        onPressed: () {
          Navigator.pop(context, product.parentId);
        },
      ),
    );
  }
}
