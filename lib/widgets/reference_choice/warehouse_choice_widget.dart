import 'package:flutter/material.dart';
import 'package:mobile_traid/api/api.dart';
//import 'package:mobile_traid/models/manager_model.dart';
import 'package:mobile_traid/providers/warehouse_watcher_provider.dart';
import 'package:mobile_traid/repository/repo.dart';
import 'package:mobile_traid/widgets/reference_choice/warehouse_widget.dart';
import 'package:provider/provider.dart';
import 'package:mobile_traid/models/entity_model.dart';

class ChoiceWarehouseWidget extends StatefulWidget {
  const ChoiceWarehouseWidget({Key? key}) : super(key: key);

  @override
  State<ChoiceWarehouseWidget> createState() => _ChoiceWarehouseWidgetState();
}

class _ChoiceWarehouseWidgetState extends State<ChoiceWarehouseWidget> {
  List<Warehouse> warehouses = [];
  var visibleLoadIndicator = true;
  // final Function onTapHandler;

  void onTapHandler(Warehouse warehouse) {
    context.read<WarehouseWatcher>().setChosenWarehouse(warehouse);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    fillWarehouses();
  }

  Future<String> fillWarehouses() async {
    List<Warehouse> data = [];
    final manager = Repo.getCurrentManager();
    data = await Api.getWarehouses(manager: manager);

    for (Warehouse warehouse in data) {
      if (Repo.getLocalOrganizations().isEmpty) {
        warehouses.add(warehouse);
        continue;
      }

      bool flag = true;
      for (Warehouse localWarehouse in Repo.getLocalWarehouses()) {
        if (localWarehouse.name == warehouse.name) {
          flag = false;
          break;
        }
      }

      if (flag == true) warehouses.add(warehouse);
    }

    setState(() {
      visibleLoadIndicator = false;
    });
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: const Text(
        'Выбор пользователя',
        style: TextStyle(fontSize: 17),
      )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            ListView.builder(
              // padding: EdgeInsets.only(top: 70),
              // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: warehouses.length, //products.length,
              itemExtent: 50,
              itemBuilder: (BuildContext context, int index) {
                return WarehouseWidget(
                  dismiss: () {},
                  warehouse: warehouses[index],
                  onTapHandler: onTapHandler,
                  index: index,
                );
              },
            ),
            Visibility(
              child: const LoadingIndicator(),
              visible: visibleLoadIndicator,
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
