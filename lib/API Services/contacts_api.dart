import 'dart:convert';
import 'dart:developer';

import 'package:portfolio/Data%20Managers/api_manager.dart';
import 'package:portfolio/Models/contact_model.dart';
import 'package:http/http.dart' as http;

class ContactsAPI {
  Future<List<ContactModel>> getContacts() async {
    try {
      final response = await http.get(
          Uri.parse("${APIManager.baseUrl}/classes/Contacts"),
          headers: APIManager.headers);
      if (response.statusCode == 200) {
        List<ContactModel> contacts = [];
        final data = jsonDecode(response.body)['results'] as List;
        for (var element in data) {
          contacts.add(ContactModel.fromJson(element));
        }
        return contacts;
      }
    } catch (e) {
      log("Get ProjectsModel Error: $e");
    }
    return [];
  }
}
