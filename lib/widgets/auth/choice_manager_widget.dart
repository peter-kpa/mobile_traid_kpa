import 'package:flutter/material.dart';
import 'package:mobile_traid/api/api.dart';
import 'package:mobile_traid/models/manager_model.dart';
import 'package:mobile_traid/providers/manager_watcher_provider.dart';
import 'package:mobile_traid/repository/repo.dart';
import 'package:mobile_traid/widgets/auth/manager_widget.dart';
import 'package:provider/provider.dart';

class ChoiceManagerWidget extends StatefulWidget {
  const ChoiceManagerWidget({Key? key}) : super(key: key);

  @override
  State<ChoiceManagerWidget> createState() => _ChoiceManagerWidgetState();
}

class _ChoiceManagerWidgetState extends State<ChoiceManagerWidget> {
  List<Manager> managers = [];
  var visibleLoadIndicator = true;
  // final Function onTapHandler;

  void onTapHandler(Manager manager) {
    context.read<ManagerWatcher>().addNewManager(manager);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    fillManagers();
  }

  Future<String> fillManagers() async {
    List<Manager> data = [];
    data = await Api.getManagers();

    for (Manager manager in data) {
      if (Repo.getLocalManagers().isEmpty) {
        managers.add(manager);
        continue;
      }

      bool flag = true;
      for (Manager localManager in Repo.getLocalManagers()) {
        if (localManager.name == manager.name) {
          flag = false;
          break;
        }
      }

      if (flag == true) managers.add(manager);
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
              itemCount: managers.length, //products.length,
              itemExtent: 50,
              itemBuilder: (BuildContext context, int index) {
                return ManagerWidget(
                  dismiss: () {},
                  manager: managers[index],
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
