//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_traid/models/entity_model.dart';
import 'package:mobile_traid/repository/repo.dart';
// import 'package:mobile_traid/providers/notifier_provider.dart';
// import 'package:mobile_traid/models/invoice_list_model.dart';
import 'package:mobile_traid/models/invoice_model.dart';
import 'package:mobile_traid/widgets/invoice/invoice_widget.dart';

class InvoiceListLineElement extends StatelessWidget {
  InvoiceListLineElement({
    Key? key,
    required this.elementText,
    required this.fieldWidth,
    required this.fieldBackGroundColor,
  }) : super(key: key);
  String elementText;
  double fieldWidth;
  Color fieldBackGroundColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: fieldBackGroundColor,
          border: Border.all(
            color: Colors.black,
            width: 2,
            style: BorderStyle.solid,
          )),
      child: SizedBox(
        width: fieldWidth,
        child: Center(
          child: Text(
            elementText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class _InvoiceListLineWidgetState extends StatelessWidget {
  _InvoiceListLineWidgetState({Key? key, required this.invoice})
      : super(key: key);

  final Invoice invoice;

  final horizontalDivider = const SizedBox(
    width: 3,
  );

  final wideHorizontalDivider = const SizedBox(
    width: 15,
  );

  final verticalDivider = const SizedBox(
    height: 3,
  );

  final verticalLineDivider = Container(
    height: 5,
    color: Colors.purple,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalDivider,
        Row(
          children: [
            horizontalDivider,
            InvoiceListLineElement(
              elementText: (invoice.internalDocumentNumber == null
                  ? ''
                  : invoice.internalDocumentNumber!),
              fieldWidth: 50,
              fieldBackGroundColor: Colors.green,
            ),
            horizontalDivider,
            InvoiceListLineElement(
              elementText: (invoice.externalDocumentNumber == null
                  ? ''
                  : invoice.externalDocumentNumber!),
              fieldWidth: 80,
              fieldBackGroundColor: Colors.green,
            ),
            horizontalDivider,
            InvoiceListLineElement(
              elementText: invoice.documentDate.toString(),
              fieldWidth: 50,
              fieldBackGroundColor: Colors.green,
            ),
            horizontalDivider,
          ],
        ),
        verticalDivider,
        Row(
          children: [
            wideHorizontalDivider,
            InvoiceListLineElement(
              elementText:
                  (invoice.tradePoint == null ? '' : invoice.tradePoint!.name),
              fieldWidth: 150,
              fieldBackGroundColor: Colors.yellow,
            ),
            horizontalDivider,
            InvoiceListLineElement(
              elementText:
                  (invoice.wareHouse == null ? '' : invoice.wareHouse!.name),
              fieldWidth: 100,
              fieldBackGroundColor: Colors.yellow,
            ),
            horizontalDivider,
            InvoiceListLineElement(
              elementText: invoice.sum.toString(),
              fieldWidth: 100,
              fieldBackGroundColor: Colors.yellow,
            ),
          ],
        ),
        verticalDivider,
        verticalLineDivider,
      ],
    );
  }
}

class InvoiceListWidget extends StatelessWidget {
  InvoiceListWidget({Key? key}) : super(key: key);
  //Invoice invoice;

  void _floatingButtonOnPressed(context) async {
    await Navigator.of(context).pushNamed('/newInvoice');
  }

  @override
  Widget build(BuildContext context) {
    // final model = NotifierProvider.watch<InvoiceListModel>(context);
    // if (model == null) {
    //   return const SizedBox.shrink();
    // }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 5,
        onPressed: () => {_floatingButtonOnPressed(context)},
      ),
      body: ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.only(top: 70),
          itemCount: 15, //model.invoiceList.length,
          //itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            //final invoice = model.invoiceList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(children: [
                Row(children: [Text('dfdfd')]),
                Row(children: [Text('rrrr')]),
              ]),
            );
          }),
    );
  }
}
