import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:portfolio/Data%20Managers/api_manager.dart';
import 'package:portfolio/Models/personal_info_model.dart';
import 'package:http/http.dart' as http;

class PersonalInfoAPI {
  Future<PersonalInfoModel> getPersonalInfo() async {
    try {
      final response = await http.get(
          Uri.parse("${APIManager.baseUrl}/classes/Info"),
          headers: APIManager.headers);
      if (response.statusCode == 200) {
        return PersonalInfoModel.fromJson(
            jsonDecode(response.body)['results'][0]);
      }
    } catch (e) {
      log("Get Personal Info Error: $e");
    }
    return PersonalInfoModel();
  }
}
