import 'package:flutter/material.dart';
//import 'package:http/http.dart';
import 'package:mobile_traid/widgets/invoice/invoice_product_list_widget.dart';
import 'package:mobile_traid/widgets/invoice/invoice_header_widget.dart';
import 'package:mobile_traid/widgets/invoice/invoice_product_list_line_widget.dart';
import 'package:mobile_traid/models/invoice_model.dart';
import 'package:uuid/uuid.dart';
import 'package:mobile_traid/repository/repo.dart';

class DocumentTabBar extends StatelessWidget {
  Invoice? invoice;
  DocumentTabBar({Key? key, this.invoice}) : super(key: key);

  Invoice? get savingInvoice => invoice;

  @override
  Widget build(BuildContext context) {
    //final watcher = context.watch();
    //invoice: initInvoice()

    Invoice? initInvoice() {
      return Invoice(
          internalDocumentNumber: Uuid().v1().toString(),
          documentDate: DateTime.now(),
          posted: false,
          deletionMark: false,
          manager: Repo.getCurrentManager(),
          organization: Repo.getCurrentOrganization(),
          docTypeName: 'realization',
          tradePoint: null,
          wareHouse: Repo.getCurrentWarehouse(),
          sum: 0.0);
    }

    void _addNewProductTabularLine(BuildContext context) async {
      //await Navigator.of(context).pushNamed('/newInvoiceProductLine').;

      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InvoiceProductListLineWidget()));
    }

    void _saveInvoice(BuildContext context) {
      // context.read()
      Invoice? currentInvoice =
          (context.widget as DocumentTabBar).savingInvoice;
      Repo.addInvoice(currentInvoice!);
      Repo.setCurrentInvoice(currentInvoice);
    }

    if (invoice == null) {
      invoice = initInvoice();
    }

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              actions: [
                PopupMenuButton(
                  itemBuilder: (contextPM) => [
                    PopupMenuItem(
                      child: const Text('Записать документ'),
                      value: 1,
                      onTap: () => {_saveInvoice(context)},
                    ),
                    PopupMenuItem(
                      child: const Text('Добавить строку'),
                      value: 2,
                      onTap: () => {_addNewProductTabularLine(context)},
                    ),
                    PopupMenuItem(
                      child: const Text('Редактировать строку'),
                      value: 3,
                      onTap: () => {},
                    )
                  ],
                )
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(
                    height: 50,
                    text: 'Шапка документа',
                    icon: Icon(Icons.business),
                  ),
                  Tab(
                    height: 50,
                    text: 'Товары',
                    icon: Icon(Icons.table_chart),
                  ),
                ],
              ),
              //title: const Text('Накладная'),
            ),
          ),
          body: TabBarView(
            children: [
              Tab(
                child: InvoiceHeaderWidget(
                  invoice: invoice,
                ),
              ),
              Tab(
                child: DocInvoiceProductsWidget(
                  invoice: invoice,
                ),
              ),
              //text: 'Товары',
              // icon: Icon(Icons.table_chart),
              // child: DocInvoicedProductsWidget(),
              //),
            ],
          ),
        ),
      ),
    );
  }
}
