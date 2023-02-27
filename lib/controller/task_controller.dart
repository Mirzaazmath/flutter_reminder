import 'package:get/get.dart';
import 'package:reminder_flutter/db/dbhelper.dart';

import '../model/taskmodel.dart';

class TaskController extends GetxController{
  var taskList=[].obs;
  @override
  void onReady(){
    super.onReady();
  }
  Future<int>addTask({Task? task})async{
    return await  DbHelper.insert(task);
  }
  void getTask()async{
    List<Map<String, dynamic>>?tasks = await DbHelper.query();
    print("calling get task");

    taskList.assignAll(tasks!.map((data)=>Task.fromJson(data)).toList() );
  }
  void delete(Task task){
    DbHelper.delete(task);
    getTask();

  }
  void markTaskCompleted(int id)async{
  await   DbHelper.update(id);
  getTask();

  }

}