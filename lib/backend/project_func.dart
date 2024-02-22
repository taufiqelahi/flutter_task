import 'dart:convert';

import 'package:flutter_task/model/project_data_model.dart';
import 'package:http/http.dart' as http;

class ProjectFunc {
  Future<List<ProjectModel>> getAllData() async {
    final response = await http.get(Uri.parse(
        'https://scubetech.xyz/projects/dashboard/all-project-elements/'));


    if (response.statusCode == 200) {
      // If the server returns an OK response, then parse the JSON.
      return projectFromJson(response.body);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
