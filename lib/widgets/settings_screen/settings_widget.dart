import 'package:flutter/material.dart';
import 'package:mobile_traid/api/api.dart';
import 'package:mobile_traid/database/database.dart';
import 'package:mobile_traid/repository/repo.dart';
//import 'package:mobile_traid/providers/manager_watcher_provider.dart';
import 'package:mobile_traid/models/entity_model.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  var visibleLoadIndicator = false;
  bool checkedRoute = false;
  bool checkedStocks = false;
  bool checkedDocuments = false;
  List requiredData = [];

  final _logTextController = TextEditingController();

  void _updateRequired() {
    requiredData.clear();
    if (checkedRoute == true) {
      requiredData.add('route');
    }
    if (checkedStocks == true) {
      requiredData.add('stocks');
    }

    setState(() {});
  }

  void _getData() async {
    setState(() {
      visibleLoadIndicator = true;
    });

    await Api.getData(
        manager: Repo.getCurrentManager()!,
        requiredData: requiredData,
        documents: []);
    _logTextController.text =
        'обмен данными заверешен... \n организации: ${Database.organizations?.length}\n склады: ${Database.warehouses.length}\n товары: ${Database.productDirectory.length}\n остатки: ${Database.stocks.length}\n маршрут: ${Database.route.length}';

    setState(() {
      visibleLoadIndicator = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Настройки'),
            bottom: const TabBar(
              //controller: () => {},
              tabs: [
                Tab(text: 'Обмен данными', icon: Icon(Icons.phone)),
                Tab(text: 'Значения по умолчанию', icon: Icon(Icons.list)),
              ],
            ),
          ),
          body: TabBarView(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(30),
                      children: [
                        SizedBox(
                          height: 30,
                          child: Row(
                            children: const [
                              Center(child: Text('Настройки обмена')),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: checkedStocks,
                                onChanged: (value) {
                                  // setState(() {
                                  checkedStocks = value!;
                                  _updateRequired();
                                  // });
                                }),
                            const Text('обновить остатки'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: checkedRoute,
                                onChanged: (value) {
                                  // setState(() {
                                  checkedRoute = value!;
                                  _updateRequired();
                                  // });
                                }),
                            const Text('обновить маршрут'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: checkedDocuments,
                                onChanged: (value) {
                                  // setState(() {
                                  checkedDocuments = value!;
                                  _updateRequired();
                                  // });
                                }),
                            const Text('выгрузить документы'),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: _getData,
                          child: const Text('Запустить обмен'),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text('Результаты обмена'),
                        TextField(
                          controller: _logTextController,
                          readOnly: true,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF01B4E4)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            isCollapsed: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    child: const LoadingIndicator(),
                    visible: visibleLoadIndicator,
                  ),
                ],
              ),
            ),
            // Страница значений по умолчанию
            DefaultSettinsWidget()
          ])),
    );
  }
}

class DefaultSettinsWidget extends StatefulWidget {
  DefaultSettinsWidget({Key? key}) : super(key: key);

  @override
  _DefaultSettinsWidgetState createState() => _DefaultSettinsWidgetState();
}

class _DefaultSettinsWidgetState extends State<DefaultSettinsWidget> {
  void _goToOrganizations(context) async {
    await Navigator.of(context).pushNamed('/choiceOrganizations');
    setState(() {});
  }

  void _goToWarehouses(context) async {
    await Navigator.of(context).pushNamed('/choiceWarehouses');
    setState(() {});
  }

  String _getChosenOrganizationName() {
    String name = '<не выбрано>';
    if (Repo.getChosenOrganization() != null) {
      name = Repo.getChosenOrganization()!.name;
    }
    return name;
  }

  String _getChosenWarehouseName() {
    String name = '<не выбрано>';
    if (Repo.getChosenWarehouse() != null) {
      name = Repo.getChosenWarehouse()!.name;
    }
    return name;
  }

  void _setDefaultValues() {
    Warehouse chosenWarehouse;
    Organization chosenOrganization;
    if (Repo.getChosenWarehouse() != null) {
      chosenWarehouse = Repo.getChosenWarehouse()!;
      Repo.setCurrentWarehouse(chosenWarehouse);
    }
    if (Repo.getChosenOrganization() != null) {
      chosenOrganization = Repo.getChosenOrganization()!;
      Repo.setCurrentOrganization(chosenOrganization);
    }
  }

  @override
  Widget build(BuildContext context) {
    const verticalDivider = SizedBox(
      height: 20,
    );
    const labelTextStyle = TextStyle(
        color: Colors.blue,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal);
    const labelBoxDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border(
        top: BorderSide(width: 2.0, color: Colors.blue),
        left: BorderSide(width: 2.0, color: Colors.blue),
        right: BorderSide(width: 2.0, color: Colors.blue),
        bottom: BorderSide(width: 2.0, color: Colors.blue),
      ),
    );

    Widget labelGroup(String label) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            width: 110,
            height: 20,
            child: Text(
              label,
              style: labelTextStyle,
            )),
      );
    }

    //final manager = Repo.getCurrentManager();
    return Column(
      children: [
        Column(
          children: [
            verticalDivider,
            Row(children: [
              labelGroup('Склад:'),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size(200, 20)),
                ),
                onPressed: () => {_goToWarehouses(context)},
                child: const Text('Выбрать склад'),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 30,
                constraints: const BoxConstraints.expand(height: 30),
                //alignment: AlignmentGeometry,
                decoration: labelBoxDecoration,
                child: Center(
                  child: Text(_getChosenWarehouseName(),
                      textAlign: TextAlign.center, style: labelTextStyle),
                ),
              ),
            ),
            verticalDivider,
            Row(
              children: [
                labelGroup('Организация:'),
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(200, 20)),
                  ),
                  onPressed: () => {_goToOrganizations(context)},
                  child: const Text('Выбрать организацию'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 30,
                constraints: const BoxConstraints.expand(height: 30),
                decoration: labelBoxDecoration,
                child: Center(
                  child: Text(_getChosenOrganizationName(),
                      textAlign: TextAlign.center, style: labelTextStyle),
                ),
              ),
            ),
            verticalDivider,
          ],
        ),
        ElevatedButton(
          onPressed: () => {_setDefaultValues()},
          child: const Text('Установить значения по умолчанию'),
        ),
      ],
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
