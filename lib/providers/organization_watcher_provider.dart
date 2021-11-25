import 'package:flutter/material.dart';
import 'package:mobile_traid/models/entity_model.dart';
import 'package:mobile_traid/repository/repo.dart';

class OrganizationWatcher with ChangeNotifier {
  List<Organization> localOrganizations = [];

  void updateLocalOrganizations() {
    localOrganizations = Repo.getLocalOrganizations();
    notifyListeners();
  }

  // void addNewOrganization(Organization organization) {
  //   Repo.addOrganization(organization);
  //   updateLocalOrganizations();
  //   // notifyListeners();
  // }

  // void removeOrganization(Organization organization) {
  //   Repo.removeOrganization(organization);
  //   updateLocalOrganizations();
  // }

  void setChosenOrganization(Organization organization) {
    Repo.setChosenOrganization(organization);
  }

  void setCurrentOrganization(Organization organization) {
    Repo.setCurrentOrganization(organization);
  }
}
