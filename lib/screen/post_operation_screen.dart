import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task/backend/project_func.dart';
import 'package:flutter_task/model/project_data_model.dart';
import 'package:intl/intl.dart';

class PostOperationScreen extends ConsumerStatefulWidget {
  final ProjectModel? projectModel;
  const PostOperationScreen({super.key, this.projectModel});

  @override
  ConsumerState<PostOperationScreen> createState() => _PostOperationScreenState();
}

class _PostOperationScreenState extends ConsumerState<PostOperationScreen> {
  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectUpdateController = TextEditingController();
  TextEditingController assignedEngineerController = TextEditingController();
  TextEditingController assignedTechnicianController = TextEditingController();

  String selectedStartDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String selectedEndDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool isEdit = false;
  void startDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final date = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: DateTime(now.year + 1, now.month, now.day));
    setState(() {
      if (date != null)
        selectedStartDate = DateFormat('yyyy-MM-dd').format(date);
    });
  }

  void endDatePicker() async {
    final now = DateTime.now();
    final lastDate = DateTime(now.year + 2, now.month, now.day);
    final date = await showDatePicker(
        context: context, initialDate: now, firstDate: DateTime.parse(selectedStartDate), lastDate: lastDate);
    setState(() {
      if (date != null) selectedEndDate = DateFormat('yyyy-MM-dd').format(date);
    });
  }

  @override
  void initState() {
    final project = widget.projectModel;
    if (project != null) {
      setState(() {
        isEdit = true;
      });

      selectedStartDate = DateFormat('yyyy-MM-dd').format(project.startDate);
      selectedEndDate = DateFormat('yyyy-MM-dd').format(project.endDate);
      projectNameController.text = project.projectName;
      projectUpdateController.text = project.projectUpdate;
      assignedEngineerController.text = project.assignedEngineer;
      assignedTechnicianController.text = project.assignedTechnician;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Project' : 'Add Project Elements'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Row(
                  children: [Text("Start Date*"), Spacer(), Text("End Date*")],
                ),
                Row(
                  children: [
                    Text(selectedStartDate),
                    const SizedBox(
                      width: 6,
                    ),
                    IconButton(
                        onPressed: startDatePicker,
                        icon: const Icon(Icons.calendar_today)),
                    const Spacer(),
                    Text(selectedEndDate),
                    const SizedBox(
                      width: 6,
                    ),
                    IconButton(
                        onPressed: endDatePicker,
                        icon: const Icon(Icons.calendar_today)),
                  ],
                ),
                TextField(
                  controller: projectNameController,
                  decoration:
                      InputDecoration(label: Text('Enter Your Project Name')),
                ),
                TextField(
                  controller: projectUpdateController,
                  decoration: InputDecoration(label: Text('Project Update')),
                ),
                TextField(
                  controller: assignedEngineerController,
                  decoration: InputDecoration(label: Text('Assigned Engineer')),
                ),
                TextField(
                  controller: assignedTechnicianController,
                  decoration:
                      InputDecoration(label: Text('Assigned Technician')),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      isEdit
                          ? await ProjectFunc().updateData(
                              context: context,
                              startDate: selectedStartDate!,
                              endDate: selectedEndDate!,
                              projectName: projectNameController.text,
                              projectUpdate: projectUpdateController.text,
                              assignedEngineer: assignedEngineerController.text,
                              assignedTechnician:
                                  assignedTechnicianController.text,
                              id: widget.projectModel!.id)
                          : await ProjectFunc().postData(
                              context: context,
                              startDate: selectedStartDate!,
                              endDate: selectedEndDate!,
                              projectName: projectNameController.text,
                              projectUpdate: projectUpdateController.text,
                              assignedEngineer: assignedEngineerController.text,
                              assignedTechnician:
                                  assignedTechnicianController.text);


                      Navigator.pop(context, 'reload');
                    },
                    child: Text(isEdit ? 'Update Task' : 'Add Task'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
