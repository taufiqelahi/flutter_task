import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_task/backend/project_func.dart';
import 'package:flutter_task/model/project_data_model.dart';
import 'package:flutter_task/post_operation_screen.dart';
import 'package:intl/intl.dart';

class GetOperationScreen extends StatefulWidget {
  const GetOperationScreen({super.key});

  @override
  State<GetOperationScreen> createState() => _GetOperationScreenState();
}

class _GetOperationScreenState extends State<GetOperationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Get All Task'),
        ),
        body: FutureBuilder(
          future: ProjectFunc().getAllData(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ProjectModel>> snapshot) {
            List<ProjectModel>? data = snapshot.data;

            if (data == null) {
              return CircularProgressIndicator();
            }
            return SingleChildScrollView(
              child: Column(
                  children: data
                      .map((e) => Card(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.projectName,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        e.assignedEngineer,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        e.assignedTechnician,
                                        maxLines: 1,
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${DateFormat.yMd().format(e.startDate)} - ${DateFormat.yMd().format(e.endDate)}"),
                                    Text(
                                        "${e.startDayOfYear.toString()}-${e.endDayOfYear}"),
                                    Text(e.duration.toString())
                                  ],
                                ),
                              ],
                            ),
                          )))
                      .toList()),
            );
          },
        ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PostOperationScreen()));
      },
      child: Icon(Icons.add),
      ),

    );

  }
}
