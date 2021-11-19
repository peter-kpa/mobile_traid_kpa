import 'package:flutter/material.dart';
import 'package:mobile_traid/api/api.dart';
//import 'package:mobile_traid/models/manager_model.dart';
import 'package:mobile_traid/providers/organization_watcher_provider.dart';
import 'package:mobile_traid/repository/repo.dart';
import 'package:mobile_traid/widgets/reference_choice/organization_widget.dart';
import 'package:provider/provider.dart';
import 'package:mobile_traid/models/entity_model.dart';

class ChoiceOrganizationWidget extends StatefulWidget {
  const ChoiceOrganizationWidget({Key? key}) : super(key: key);

  @override
  State<ChoiceOrganizationWidget> createState() =>
      _ChoiceOrganizationWidgetState();
}

class _ChoiceOrganizationWidgetState extends State<ChoiceOrganizationWidget> {
  List<Organization> organizations = [];
  var visibleLoadIndicator = true;
  // final Function onTapHandler;

  void onTapHandler(Organization organization) {
    context.read<OrganizationWatcher>().addNewOrganization(organization);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    fillOrganizations();
  }

  Future<String> fillOrganizations() async {
    List<Organization> data = [];
    final manager = Repo.getCurrentManager();
    data = await Api.getOrganizations(manager: manager);

    for (Organization organization in data) {
      if (Repo.getLocalOrganizations().isEmpty) {
        organizations.add(organization);
        continue;
      }

      bool flag = true;
      for (Organization localOrganization in Repo.getLocalOrganizations()) {
        if (localOrganization.name == organization.name) {
          flag = false;
          break;
        }
      }

      if (flag == true) organizations.add(organization);
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
              itemCount: organizations.length, //products.length,
              itemExtent: 50,
              itemBuilder: (BuildContext context, int index) {
                return OrganizationWidget(
                  dismiss: () {},
                  organization: organizations[index],
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
