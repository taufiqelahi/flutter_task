import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_task/backend/project_func.dart';
import 'package:intl/intl.dart';

class PostOperationScreen extends StatefulWidget {
  const PostOperationScreen({super.key});

  @override
  State<PostOperationScreen> createState() => _PostOperationScreenState();
}

class _PostOperationScreenState extends State<PostOperationScreen> {
  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectUpdateController = TextEditingController();
  TextEditingController assignedEngineerController = TextEditingController();
  TextEditingController assignedTechnicianController = TextEditingController();

  String? selectedStartDate;
  String? selectedEndDate;
  void startDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final date = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selectedStartDate = DateFormat('yyyy-MM-dd').format(date!);
    });
  }

  void endDatePicker() async {
    final now = DateTime.now();
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final date = await showDatePicker(
        context: context, initialDate: now, firstDate: now, lastDate: lastDate);
    setState(() {
      selectedEndDate = DateFormat('yyyy-MM-dd').format(date!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project Elements'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Row(
                children: [Text("Start Date*"), Spacer(), Text("End Date*")],
              ),
              Row(
                children: [
                  Text(selectedStartDate == null
                      ? 'No Date Chosen'
                      : selectedStartDate!),
                  const SizedBox(
                    width: 6,
                  ),
                  IconButton(
                      onPressed: startDatePicker,
                      icon: const Icon(Icons.calendar_today)),
                  const Spacer(),
                  Text(selectedEndDate == null
                      ? 'No Date Chosen'
                      : selectedEndDate!),
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
                decoration: InputDecoration(label: Text('Assigned Technician')),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                   await ProjectFunc().postData(
                        startDate: selectedStartDate!,
                        endDate: selectedEndDate!,
                        projectName: projectNameController.text,
                        projectUpdate: projectUpdateController.text,
                        assignedEngineer: assignedEngineerController.text,
                        assignedTechnician: assignedTechnicianController.text);

                   Navigator.pop(context);
                  },
                  child: const Text('Add Task'))
            ],
          ),
        ),
      ),
    );
  }
}