import 'package:to_do_list/source/model/DBConnectivity.dart';
import 'package:to_do_list/source/model/Task.dart';

class getAllTasks {
  Future<List<Task>> getTasks() async {
    List<Task> tasks = await DBFcts().getAllTasks();
    for (Task task in tasks) {
      print("Task ID: ${task.id}");
      print("Title: ${task.title}");
      print("Description: ${task.description}");
      print("Day: ${task.day}");
      print("Start Time: ${task.startTime}");
      print("Due Time: ${task.dueTime}");
      print("Priority: ${task.priority}");
      print("Status: ${task.status}");
      print("----------");
      // DBFcts().deleteTask(task.id!);
    }
    return tasks;
  }
}
