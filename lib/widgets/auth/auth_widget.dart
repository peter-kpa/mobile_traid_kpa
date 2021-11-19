import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile_traid/models/manager_model.dart';
import 'package:mobile_traid/providers/manager_watcher_provider.dart';
import 'package:mobile_traid/widgets/auth/manager_widget.dart';

class AuthScreenWidget extends StatelessWidget {
  const AuthScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Мобильная торговля')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [Text('Пользователи', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))],
            ),
            const SizedBox(
              height: 10,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
                maxHeight: 277,
              ),
              child: ListView(
                shrinkWrap: true,
                children:
                    context.watch<ManagerWatcher>().localManagers.map((e) => DismissManagerWidget(manager: e)).toList(),
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/choiceManager');
                },
                child: const Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}

class DismissManagerWidget extends StatelessWidget {
  final Manager manager;
  const DismissManagerWidget({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Подтверждение удаления"),
              content: const Text("Вы уверены, что хотите удалить менеджера?"),
              actions: <Widget>[
                TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text("Удалить")),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Отмена"),
                ),
              ],
            );
          },
        );
      },
      // background: Container(color: Colors.red),
      onDismissed: (direction) {
        context.read<ManagerWatcher>().removeManager(manager);
      },
      child: ManagerWidget(
        manager: manager,
        index: context.read<ManagerWatcher>().localManagers.indexOf(manager),
        dismiss: () {
          context.read<ManagerWatcher>().removeManager(manager);
        },
        onTapHandler: (e) {
          context.read<ManagerWatcher>().setCurrentManager(e);
          Navigator.pushNamed(context, '/main');
        },
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
