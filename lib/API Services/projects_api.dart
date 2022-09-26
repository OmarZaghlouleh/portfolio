import 'dart:convert';
import 'dart:developer';
import 'package:portfolio/Data%20Managers/api_manager.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio/Models/project_model.dart';

class ProjectsAPI {
  Future<List<ProjectsModel>> getProjects() async {
    try {
      final response = await http.get(
          Uri.parse("${APIManager.baseUrl}/classes/Projects"),
          headers: APIManager.headers);
      log(response.body);
      if (response.statusCode == 200) {
        List<ProjectsModel> projects = [];
        final data = jsonDecode(response.body)['results'] as List;
        for (var element in data) {
          projects.add(ProjectsModel.fromJson(element));
        }
        return projects;
      }
    } catch (e) {
      log("Get ProjectsModel Error: $e");
    }
    return [];
  }
}
