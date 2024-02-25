import 'package:flutter_task/backend/project_func.dart';
import 'package:flutter_task/model/project_data_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'fetch_data_controller.g.dart';

@riverpod
class GetData extends _$GetData {
  @override
  build()=>ProjectFunc().getAllData();
}
