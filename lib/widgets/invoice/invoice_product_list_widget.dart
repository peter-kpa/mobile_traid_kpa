import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_traid/models/entity_model.dart';
import 'package:mobile_traid/models/invoice_model.dart';
// import 'package:mobile_traid/providers/tap_watcher_provider.dart';
// import 'package:provider/src/provider.dart';

class TabularSectionLineWidget extends StatefulWidget {
  final Invoice? invoice;
  int lineNumber;
  TabularSectionLine? tabularSectionLine;

  TabularSectionLineWidget({
    Key? key,
    this.invoice,
    required this.lineNumber,
    required this.tabularSectionLine,
  }) : super(key: key);

  int get currentLineNumber => lineNumber;
  TabularSectionLine? get currentTabularSectionLine => tabularSectionLine;

  @override
  _TabularSectionLineWidgetState createState() =>
      _TabularSectionLineWidgetState();
}

class TabularSectionLineElement extends StatelessWidget {
  TabularSectionLineElement(
      {Key? key,
      required this.elementText,
      required this.fieldWidth,
      required this.fieldBackGroundColor,
      required this.lineNumber})
      : super(key: key);
  String elementText;
  double fieldWidth;
  Color fieldBackGroundColor;
  int lineNumber;

  @override
  Widget build(BuildContext context) {
    void _editTabularLine(BuildContext context) {
      //context.widget.lineNumber
      int a = 1;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: fieldBackGroundColor,
          border: Border.all(
            color: Colors.black,
            width: 2,
            style: BorderStyle.solid,
          )),
      child: GestureDetector(
        onTap: () => _editTabularLine(context),
        child: SizedBox(
          width: fieldWidth,
          height: 40,
          child: Center(
            child: Text(
              elementText,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabularSectionLineWidgetState extends State<TabularSectionLineWidget> {
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
            TabularSectionLineElement(
              elementText: widget.lineNumber.toString(),
              fieldWidth: 40,
              fieldBackGroundColor: Colors.green,
              lineNumber: widget.lineNumber,
            ),
            horizontalDivider,
            TabularSectionLineElement(
              elementText: 'ProductId',
              fieldWidth: 100,
              fieldBackGroundColor: Colors.green,
              lineNumber: widget.lineNumber,
            ),
            horizontalDivider,
            TabularSectionLineElement(
              elementText: 'ProductName',
              fieldWidth: 255,
              fieldBackGroundColor: Colors.green,
              lineNumber: widget.lineNumber,
            ),
            horizontalDivider,
          ],
        ),
        verticalDivider,
        Row(
          children: [
            wideHorizontalDivider,
            TabularSectionLineElement(
              elementText: 'ProductQuantity',
              fieldWidth: 150,
              fieldBackGroundColor: Colors.yellow,
              lineNumber: widget.lineNumber,
            ),
            horizontalDivider,
            TabularSectionLineElement(
              elementText: 'ProductPrice',
              fieldWidth: 100,
              fieldBackGroundColor: Colors.yellow,
              lineNumber: widget.lineNumber,
            ),
            horizontalDivider,
            TabularSectionLineElement(
              elementText: 'ProductSum',
              fieldWidth: 120,
              fieldBackGroundColor: Colors.yellow,
              lineNumber: widget.lineNumber,
            ),
          ],
        ),
        verticalDivider,
        verticalLineDivider,
      ],
    );
  }
}

class DocInvoiceProductsWidget extends StatefulWidget {
  final Invoice? invoice;
  DocInvoiceProductsWidget({
    Key? key,
    this.invoice,
  }) : super(key: key);

  @override
  State<DocInvoiceProductsWidget> createState() =>
      _DocInvoiceProductsWidgetState();
}

class _DocInvoiceProductsWidgetState extends State<DocInvoiceProductsWidget> {
  @override
  Widget build(BuildContext context) {
    // const decorationStyle = InputDecoration(
    //   border: OutlineInputBorder(
    //       borderSide: BorderSide(color: Colors.black, width: 3)),
    //   contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    //   isCollapsed: true,
    // );
    // const textStyle20 = TextStyle(
    //   fontSize: 20,
    // );
    // const sizedBoxW10 = SizedBox(
    //   width: 10,
    // );
    // const sizedBoxH10 = SizedBox(
    //   height: 10,
    // );

    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return TabularSectionLineWidget(
              //invoice: invoice,
              lineNumber: index,
              tabularSectionLine: null,
            );
          }, childCount: 25),
        )
      ],
    );
  }
}
