import 'package:flutter/material.dart';
import 'package:mobile_traid/providers/main_screen_watcher_provider.dart';
import 'package:mobile_traid/widgets/invoice/invoice_list_widget.dart';
import 'package:provider/src/provider.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<MainScreenWatcher>().getTitle()),
      ),
      body: IndexedStack(
        index: context.watch<MainScreenWatcher>().bottomNavIndex,
        children: [
          InvoiceListWidget(),
          Container(),
          const MainWidget(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<MainScreenWatcher>().bottomNavIndex,
        onTap: (index) {
          context.read<MainScreenWatcher>().setBottomNavIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Заказы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_shopping_cart_outlined),
            label: 'Возвраты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  void _goToSettings(context) {
    Navigator.of(context).pushNamed('/settings');
  }

  void _goToProductDir(context) {
    Navigator.of(context).pushNamed('/productDir');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(50),
      children: [
        ElevatedButton(
          child: const Text('Настройки'),
          onPressed: () {
            _goToSettings(context);
          },
        ),
        ElevatedButton(
          child: const Text('Номенклатура'),
          onPressed: () {
            _goToProductDir(context);
          },
        ),
      ],
    );
  }
}
