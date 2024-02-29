import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task/backend/project_func.dart';
import 'package:flutter_task/model/project_data_model.dart';
import 'package:flutter_task/post_operation_screen.dart';
import 'package:flutter_task/provider/fetch_data_controller.dart';
import 'package:intl/intl.dart';

class GetOperationScreen extends ConsumerWidget {
  const GetOperationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get All Task'),
      ),
      body: FutureBuilder(
        future: ref.watch(getDataProvider.future),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProjectModel>> snapshot) {
          List<ProjectModel>? data = snapshot.data;

          if (data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
                children: data
                    .map((e) => Card(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    ),
                                    Text(
                                      e.projectUpdate,
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
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
                              const SizedBox(
                                width: 10,
                              ),
                              CupertinoButton(
                                  child: Icon(
                                    Icons.edit_note,
                                    color: Colors.grey[700],
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PostOperationScreen(
                                                  projectModel: e,
                                                )));
                                  }),
                            ],
                          ),
                        )))
                    .toList()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PostOperationScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
