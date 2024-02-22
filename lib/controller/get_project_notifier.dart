import 'package:flutter_task/model/project_data_model.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'get_project_notifier.g.dart'; // Generated code

@riverpod
class GetProjectNotifier extends _$GetProjectNotifier {

@override
ProjectModel? build()=>null;
  void increment() {
    // Update the state when the increment method is called
    state = state;
  }
}