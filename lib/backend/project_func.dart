import 'dart:convert';

import 'package:flutter_task/controller/get_project_notifier.dart';
import 'package:flutter_task/model/project_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectFunc {
  Future<List<ProjectModel>> getAllData() async {
    final response = await http.get(Uri.parse(
        'https://scubetech.xyz/projects/dashboard/all-project-elements/'));

    if (response.statusCode == 200) {
      // If the server returns an OK response, then parse the JSON.
      // ref.watch(getProjectNotifierProvider.notifier).getAllData(projectModel: response.body);
      return projectFromJson(response.body);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<void> postData(
      {required String startDate,
      required String endDate,
      required String projectName,
      required String projectUpdate,
      required String assignedEngineer,
      required String assignedTechnician}) async {
    final url = Uri.parse(
        'https://scubetech.xyz/projects/dashboard/add-project-elements/'); //Repclace Your Endpoint
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "start_date": startDate,
      "end_date": endDate,
      "project_name": projectName,
      "project_update": projectUpdate,
      "assigned_engineer": assignedEngineer,
      "assigned_technician": assignedTechnician,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Data Sending Success.');
    } else {
      print('Hata: ${response.statusCode}');
    }
  }

  Future<void> updateData(
      {required String startDate,
      required int id,
      required String endDate,
      required String projectName,
      required String projectUpdate,
      required String assignedEngineer,
      required String assignedTechnician}) async {
    final url = Uri.parse(
        'https://scubetech.xyz/projects/dashboard/update-project-elements/$id/'); // Replace with your endpoint
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      // Your data to be sent in the request body
      "start_date": startDate,
      "end_date": endDate,
      "project_name": projectName,
      "project_update": projectUpdate,
      "assigned_engineer": assignedEngineer,
      "assigned_technician": assignedTechnician,
      // Add other fields as needed
    });

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Data updated successfully.');
    } else {
      print('Failed to update data. Error: ${response.statusCode}');
    }
  }
}
