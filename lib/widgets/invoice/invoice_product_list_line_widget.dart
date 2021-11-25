import 'package:flutter/material.dart';
import 'package:mobile_traid/widgets/product_dir_screen/product_dir_widget.dart';
import 'package:mobile_traid/models/product_model.dart';
import 'package:mobile_traid/repository/repo.dart';
import 'package:intl/intl.dart';
import 'package:validators/sanitizers.dart';
import 'package:validators/validators.dart';
//import 'package:mobile_traid/widgets/reference_choice/organization_choice_widget.dart';
//import 'package:mobile_traid/widgets/reference_choice/warehouse_choice_widget.dart';
//import 'package:provider/src/provider.dart';

class InvoiceProductListLineWidget extends StatefulWidget {
  InvoiceProductListLineWidget({Key? key}) : super(key: key);

  @override
  State<InvoiceProductListLineWidget> createState() =>
      _InvoiceProductListLineWidgetState();
}

class _InvoiceProductListLineWidgetState
    extends State<InvoiceProductListLineWidget> {
  Product? _product;
  double _price = 0;
  double _quantity = 0;
  double _sum = 0;

  final _productController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _sumController = TextEditingController();

  bool _checkedNewLine = true;

  @override
  void dispose() {
    _productController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _sumController.dispose();
    super.dispose();
  }

  void _goToProductDir(context) async {
    //await Navigator.of(context).pushNamed('/productDir');
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProductDirWidget()));

    if (Repo.getChosenProduct() != null) {
      _product = Repo.getChosenProduct();
      _price = _product!.price;
      _priceController.text = NumberFormat("#####0.00").format(_price);
    }
    _sum = _quantity * _price;
    _sumController.text = NumberFormat("#####0.00").format(_sum);
    setState(() {});
  }

  String _getProductName() {
    return (_product == null ? '' : _product!.name);
  }

  String _getProductCode() {
    return (_product == null ? '' : _product!.id);
  }

  String _getProductPrice() {
    double currentPrice = 0;
    currentPrice = (_product == null ? 0 : _product!.price);
    _price = currentPrice;
    return NumberFormat("#####0.00").format(currentPrice);
  }

  void _onInputQuantity() {
    _quantity = 0;
    if (isNumeric(_quantityController.text)) {
      _quantity = toFloat(_quantityController.text);
    } else {
      if (isFloat(_quantityController.text)) {
        _quantity = toFloat(_quantityController.text);
      } else {
        _quantity = 0;
      }
    }
    _sum = _quantity * _price;
    _sumController.text = NumberFormat("#####0.00").format(_sum);
  }

  void _onInputSum() {
    _sum = 0;
    if (isNumeric(_sumController.text)) {
      _sum = toFloat(_sumController.text);
    } else {
      if (isFloat(_sumController.text)) {
        _sum = toFloat(_sumController.text);
      } else {
        _sum = 0;
      }
    }
    _quantity = _price == 0 ? 0 : _sum * _price;
    _quantityController.text = NumberFormat("#####0.00").format(_quantity);
  }

  void _cancelInput(BuildContext context) {}

  void _submitLine(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    const decorationStyle = InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 3)),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isCollapsed: true,
    );
    const textStyle20 = TextStyle(
      fontSize: 20,
    );
    const sizedBoxW10 = SizedBox(
      width: 10,
    );
    const sizedBoxH10 = SizedBox(
      height: 10,
    );
    const labelWidth = 150.0;
    const fieldWidth = 150.0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            sizedBoxH10,
            sizedBoxH10,
            sizedBoxH10,
            sizedBoxH10,
            GestureDetector(
              onTap: () => {_goToProductDir(context)},
              child: SizedBox(
                width: 250,
                height: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      'Номенклатура:',
                      textAlign: TextAlign.center,
                      style: textStyle20,
                    ),
                  ),
                ),
              ),
            ),
            sizedBoxH10,
            sizedBoxH10,
            Row(
              children: [
                sizedBoxW10,
                sizedBoxW10,
                sizedBoxW10,
                const SizedBox(
                  width: labelWidth,
                  child: Text(
                    'код:',
                    style: textStyle20,
                  ),
                ),
                sizedBoxW10,
                SizedBox(
                  width: fieldWidth,
                  child: Text(
                    _getProductCode(),
                    style: textStyle20,
                  ),
                )
              ],
            ),
            sizedBoxH10,
            Row(
              children: [
                sizedBoxW10,
                sizedBoxW10,
                sizedBoxW10,
                const SizedBox(
                  width: labelWidth,
                  child: Text(
                    'наименование:',
                    style: textStyle20,
                  ),
                ),
                sizedBoxW10,
                SizedBox(
                  width: fieldWidth,
                  child: Text(
                    _getProductName(),
                    style: textStyle20,
                  ),
                )
              ],
            ),
            sizedBoxH10,
            Row(
              children: [
                sizedBoxW10,
                sizedBoxW10,
                sizedBoxW10,
                const SizedBox(
                  width: labelWidth,
                  child: Text(
                    'цена:',
                    style: textStyle20,
                  ),
                ),
                sizedBoxW10,
                SizedBox(
                  width: fieldWidth,
                  child: Text(
                    _getProductPrice(),
                    style: textStyle20,
                  ),
                )
              ],
            ),
            sizedBoxH10,
            Row(
              children: [
                sizedBoxW10,
                const SizedBox(
                  width: labelWidth,
                  child: Text(
                    'Количество:',
                    style: textStyle20,
                  ),
                ),
                sizedBoxW10,
                SizedBox(
                  width: fieldWidth,
                  child: TextFormField(
                    //validator: (value) => { if  isNumeric(value)},
                    onEditingComplete: () => {_onInputQuantity()},
                    decoration: decorationStyle,
                    controller: _quantityController,
                    style: textStyle20,
                  ),
                )
              ],
            ),
            sizedBoxH10,
            Row(
              children: [
                sizedBoxW10,
                const SizedBox(
                  width: labelWidth,
                  child: Text(
                    'Сумма:',
                    style: textStyle20,
                  ),
                ),
                sizedBoxW10,
                SizedBox(
                  width: fieldWidth,
                  child: TextField(
                    onEditingComplete: () => {_onInputSum()},
                    decoration: decorationStyle,
                    controller: _sumController,
                    style: textStyle20,
                  ),
                )
              ],
            ),
            Row(
              children: [
                sizedBoxW10,
                ElevatedButton(
                  onPressed: () => {_submitLine(context)},
                  child: const Text('Записать строку'),
                ),
                SizedBox(
                  width: 250,
                  child: CheckboxListTile(
                    title: const Text(
                      'Вводить новую строку',
                      textAlign: TextAlign.right,
                      //style: textStyle20,
                    ),
                    value: _checkedNewLine,
                    onChanged: (bool? value) {
                      _checkedNewLine = value!;
                      //_setInputRegime();
                    },
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => {_cancelInput(context)},
              child: const Text('Выйти из режима ввода'),
            )
          ],
        ),
      ),
    );
  }
}
