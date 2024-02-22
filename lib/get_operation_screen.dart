import 'package:flutter/material.dart';
import 'package:flutter_task/backend/project_func.dart';
import 'package:flutter_task/model/project_data_model.dart';

class GetOperationScreen extends StatelessWidget {
  const GetOperationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get All Task'),
      ),
      body: FutureBuilder(
        future: ProjectFunc().getAllData(), builder: (BuildContext context, AsyncSnapshot<List<ProjectModel>> snapshot) {
    List<ProjectModel>?data=snapshot.data;

    if(data==null){
      return CircularProgressIndicator();
    }
    return SingleChildScrollView(
      child: Column(
      children: data.map((e) => Text(e.startDate.toIso8601String())).toList()
      ),
    );



    },
    )
    );
  }
}
