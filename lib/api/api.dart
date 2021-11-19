import 'dart:convert';
//import 'dart:html';
import 'dart:io';
import 'dart:async';
import 'package:mobile_traid/models/manager_model.dart';
import 'package:mobile_traid/models/entity_model.dart';
import 'package:mobile_traid/models/product_model.dart';
import 'package:mobile_traid/repository/repo.dart';

abstract class Api {
  static getData(
      {Manager? manager,
      List requiredData = const [],
      List documents = const []}) async {
    Map<String, dynamic> body = {};
    body['manager'] = manager!.name;
    body['requiredData'] = requiredData;
    body['documents'] = documents;

    final client = HttpClient();
    final url = Uri.parse('https://sdp29.ru/torgtemp/hs/exchange/get_data');
    final request = await client.postUrl(url);
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    request.write(jsonEncode(body));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    // print(jsonString);
    final json = jsonDecode(jsonString) as Map<String, dynamic>;

    _saveData(json);
  }

  static void _saveData(Map<String, dynamic> json) {
    Repo.clearProducts();
    Repo.saveProducts((json['productDirectory'] as List<dynamic>)
        .map((dynamic e) => Product.fromJson(e as Map<String, dynamic>))
        .toList());
  }

  static getManagers() async {
    Completer completer = Completer();
    final client = HttpClient();
    final url = Uri.parse('https://sdp29.ru/torgtemp/hs/exchange/get_data');
    final request = await client.getUrl(url);
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    // request.write(jsonEncode(body));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    completer.complete(jsonStrings);
    // print(jsonString);
    final managersMaps = jsonDecode(jsonString) as List<dynamic>;

    List<Manager> managers = [];
    managers = List.from(managersMaps.map((e) => Manager.fromJson(e)));

    return managers;
  }

  static getOrganizations({Manager? manager}) async {
    if (Manager == null) {
      return;
    }
    Completer completer = Completer();
    Map<String, dynamic> body = {};
    body['manager'] = manager!.name;
    body['requiredData'] = [];
    body['documents'] = [];

    final client = HttpClient();
    final url = Uri.parse('https://sdp29.ru/torgtemp/hs/exchange/get_data');
    final request = await client.postUrl(url);
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    request.write(jsonEncode(body));
    var response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    completer.complete(jsonStrings);
    // print(jsonString);
    final json = await jsonDecode(jsonString) as Map<String, dynamic>;
    List<Organization> organizations = [];

    if (json.containsKey('organizations')) {
      json.forEach((key, value) {
        if (key == 'organizations') {
          final listOrganizations = value as List;
          organizations =
              List.from(listOrganizations.map((e) => Organization.fromJson(e)));
          //break;
          //return organizations;
        }
      });
    }
    //_saveData(json);
    return organizations;
    // Repo.clearOrganizations();
    // Repo. (organizations);
  }
}
