import 'dart:convert';

List<ProjectModel> projectFromJson(String str) => List<ProjectModel>.from(
    json.decode(str).map((x) => ProjectModel.fromJson(x)));

String projectToJson(List<ProjectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectModel {
  int id;
  DateTime startDate;
  DateTime endDate;
  int startDayOfYear;
  int endDayOfYear;
  String projectName;
  String projectUpdate;
  String assignedEngineer;
  String assignedTechnician;
  int duration;

  ProjectModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.startDayOfYear,
    required this.endDayOfYear,
    required this.projectName,
    required this.projectUpdate,
    required this.assignedEngineer,
    required this.assignedTechnician,
    required this.duration,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json["id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        startDayOfYear: json["start_day_of_year"],
        endDayOfYear: json["end_day_of_year"],
        projectName: json["project_name"],
        projectUpdate: json["project_update"],
        assignedEngineer: json["assigned_engineer"],
        assignedTechnician: json["assigned_technician"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_date":startDate,
        "end_date":endDate,
        "start_day_of_year": startDayOfYear,
        "end_day_of_year": endDayOfYear,
        "project_name": projectName,
        "project_update": projectUpdate,
        "assigned_engineer": assignedEngineer,
        "assigned_technician": assignedTechnician,
        "duration": duration,
      };
}
