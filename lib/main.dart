import 'package:flutter/material.dart';
import 'package:mobile_traid/providers/main_screen_watcher_provider.dart';
import 'package:mobile_traid/providers/organization_watcher_provider.dart';
import 'package:mobile_traid/providers/manager_watcher_provider.dart';
import 'package:mobile_traid/providers/product_watcher_provider.dart';
import 'package:mobile_traid/widgets/auth/auth_widget.dart';
import 'package:mobile_traid/widgets/auth/choice_manager_widget.dart';
import 'package:provider/provider.dart';
import 'package:mobile_traid/widgets/product_dir_screen/product_card_widget.dart';
import 'package:mobile_traid/widgets/product_dir_screen/product_dir_widget.dart';
import 'package:mobile_traid/widgets/settings_screen/settings_widget.dart';
import 'package:mobile_traid/widgets/main_screen/main_screen_widget.dart';
import 'package:mobile_traid/widgets/reference_choice/organization_choice_widget.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context) => MainScreenWatcher()),
        ChangeNotifierProvider(create: (context) => ManagerWatcher()),
        ChangeNotifierProvider(create: (context) => OrganizationWatcher()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile trade',
      routes: {
        '/auth': (context) => const AuthScreenWidget(),
        '/choiceManager': (context) => const ChoiceManagerWidget(),
        '/main': (context) => ChangeNotifierProvider(
            create: (context) => MainScreenWatcher(),
            child: const MainScreenWidget()),
        '/settings': (context) => const SettingsWidget(),
        '/choiceOrganizations': (context) => const ChoiceOrganizationWidget(),
        '/productDir': (context) => ChangeNotifierProvider(
            create: (context) => ProductWatcher(),
            child: const ProductDirWidget()),
        '/productCard': (context) => const ProductCardWidget(),
      },
      initialRoute: '/auth',
    );
  }
}
