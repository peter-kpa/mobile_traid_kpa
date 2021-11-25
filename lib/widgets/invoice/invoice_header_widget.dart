import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:mobile_traid/models/entity_model.dart';
import 'package:mobile_traid/models/manager_model.dart';
import 'package:mobile_traid/models/invoice_model.dart';
import 'package:mobile_traid/repository/repo.dart';
import 'package:intl/intl.dart';
import 'package:mobile_traid/widgets/reference_choice/organization_choice_widget.dart';
import 'package:mobile_traid/widgets/reference_choice/warehouse_choice_widget.dart';
import 'package:mobile_traid/widgets/invoice/invoice_product_list_line_widget.dart';
//import 'package:provider/src/provider.dart';

class InvoiceHeaderWidget extends StatefulWidget {
  Invoice? invoice;
  InvoiceHeaderWidget({Key? key, this.invoice}) : super(key: key);

  @override
  State<InvoiceHeaderWidget> createState() => _InvoiceHeaderWidgetState();
}

class _InvoiceHeaderWidgetState extends State<InvoiceHeaderWidget> {
  String? _internalDocumentNumber; // = Uuid().v1().toString();
  Organization? _currentOrganization; // = Repo.getCurrentOrganization();
  Warehouse? _currentWarehouse; // = Repo.getCurrentWarehouse();
  Manager? _currentManager; // = Repo.getCurrentManager();
  DateTime? _documentDate; // = DateTime.now();
  final _organizationController = TextEditingController();
  final _warehouseController = TextEditingController();
  final _currentDateController = TextEditingController();

  @override
  void dispose() {
    _organizationController.dispose();
    _warehouseController.dispose();
    _currentDateController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _documentDate!,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != _documentDate) {
      _documentDate = selected;
      _currentDateController.text =
          DateFormat('dd.MM.yyyy').format(_documentDate!);
      widget.invoice?.documentDate = _documentDate!;
      //setState(() {});
    }
  }

  void _goToOrganizations(context) async {
    // await Navigator.of(context).pushNamed('/choiceOrganizations');
    // setState(() {});
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ChoiceOrganizationWidget()));
    if (Repo.getChosenOrganization() != null) {
      _currentOrganization = Repo.getChosenOrganization();
      _organizationController.text = _currentOrganization!.name;
    }
    widget.invoice?.organization = _currentOrganization;
    // setState(() {
    //   _organizationController.text = _currentOrganization!.name;
    // });
  }

  void _goToWarehouses(context) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ChoiceWarehouseWidget()));
    if (Repo.getChosenWarehouse() != null) {
      _currentWarehouse = Repo.getChosenWarehouse();
      _warehouseController.text = _currentWarehouse!.name;
    }
    widget.invoice?.wareHouse = _currentWarehouse;
    //setState(() {});
  }

  String _getCurrentOrganizationName() {
    String name = '';
    if (Repo.getCurrentOrganization() != null) {
      name = Repo.getCurrentOrganization()!.name;
    }
    return name;
  }

  String _getCurrentWarehouseName() {
    String name = '';
    if (Repo.getCurrentWarehouse() != null) {
      name = Repo.getCurrentWarehouse()!.name;
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    Invoice? _invoice = widget.invoice;
    _internalDocumentNumber = _invoice!.internalDocumentNumber;
    _currentOrganization = _invoice.organization;
    _currentWarehouse = _invoice.wareHouse;
    _currentManager = _invoice.manager;
    _documentDate = (_invoice.documentDate == null
        ? DateTime.now()
        : _invoice.documentDate);

    _organizationController.text =
        (_currentOrganization == null) ? '' : _currentOrganization!.name;
    _warehouseController.text =
        (_currentWarehouse == null) ? '' : _currentWarehouse!.name;
    _currentDateController.text =
        DateFormat('dd.MM.yyyy').format(_documentDate!);

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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            sizedBoxH10,
            SizedBox(
              width: 400,
              child: TextFormField(
                readOnly: true,
                initialValue: _internalDocumentNumber,
                style: textStyle20,
                decoration: decorationStyle,
              ),
            ),
            sizedBoxH10,
            Row(
              children: [
                sizedBoxW10,
                const Text('Номер:', style: textStyle20),
                sizedBoxW10,
                SizedBox(
                  width: 200,
                  child: TextField(
                    style: textStyle20,
                    decoration: decorationStyle,
                  ),
                ),
              ],
            ),
            sizedBoxH10,
            Row(
              children: [
                sizedBoxW10,
                const Text('от:', style: textStyle20),
                sizedBoxW10,
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    controller: _currentDateController,
                    style: textStyle20,
                    //initialValue: DateFormat('dd.MM.yyyy').format(_documentDate),
                    onTap: () => _selectDate(context),
                    decoration: decorationStyle,
                  ),
                ),
              ],
            ),
            sizedBoxH10,
            Row(
              children: [
                sizedBoxW10,
                const Text('Менеджер:', style: textStyle20),
                sizedBoxW10,
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    readOnly: true,
                    style: textStyle20,
                    initialValue: _currentManager?.name,
                    //onTap: () => {},
                    decoration: decorationStyle,
                  ),
                ),
              ],
            ),
            sizedBoxH10,
            Row(
              children: [
                sizedBoxW10,
                const Text('Организация:', style: textStyle20),
                sizedBoxW10,
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    controller: _organizationController,
                    style: textStyle20,
                    //initialValue: _currentOrganization?.name,
                    onTap: () => _goToOrganizations(context),
                    decoration: decorationStyle,
                  ),
                ),
              ],
            ),
            sizedBoxH10,
            Row(
              children: [
                sizedBoxW10,
                const Text('Склад:', style: textStyle20),
                sizedBoxW10,
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    controller: _warehouseController,
                    style: textStyle20,
                    //initialValue: _currentWarehouse?.name,
                    onTap: () => _goToWarehouses(context),
                    decoration: decorationStyle,
                  ),
                ),
              ],
            ),
            // ElevatedButton(
            //     child: Text('press'),
            //     onPressed: () => {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) =>
            //                       InvoiceProductListLineWidget()))
            //         }),
          ],
        ),
      ),
    );
  }
}
