import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task/model/project_data_model.dart';
import 'package:http/http.dart' as http;

class ProjectFunc {
  Future<List<ProjectModel>> getAllData() async {
    final response = await http.get(Uri.parse(
        'https://scubetech.xyz/projects/dashboard/all-project-elements/'));

    if (response.statusCode == 200) {

      return projectFromJson(response.body);

    } else {

      throw Exception('Failed to load post');
    }
  }

  Future<void> postData(
      {required String startDate,
        required BuildContext context,
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

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data Added successfully.'),
          backgroundColor: Colors.blueGrey[800],
          duration: Duration(seconds: 2),
        ),
      );
      print('Data Sending Success.');
    } else {
      print('Hata: ${response.statusCode}');
    }
  }

  Future<void> updateData(

      {required String startDate,
      required int id,
       required BuildContext context,
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
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           backgroundColor: Colors.blueGrey[800],
           elevation: 6.0,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(10.0),
           ),


           duration: Duration(seconds: 3),

           content: Text('Data updated successfully.'),




         ),
       );
  }else {
      print('Failed to update data. Error: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update data. Error: ${response.statusCode}'),
          duration: const Duration(seconds: 2),
        ),
      );

    }
  }
}
