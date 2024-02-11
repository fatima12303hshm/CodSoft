import 'package:to_do_list/source/model/DBConnectivity.dart';
import 'package:to_do_list/source/model/Task.dart';

class GetCurrentTask {
  GetCurrentTask();

  Future<Task?> getOngoingTask() async {
    Task? task = await DBFcts().getCurrentTask();
    if (task != null) {
      print("Task ID: ${task.id}");
      print("Title: ${task.title}");
      print("Description: ${task.description}");
      print("Day: ${task.day}");
      print("Start Time: ${task.startTime}");
      print("Due Time: ${task.dueTime}");
      print("Priority: ${task.priority}");
      print("Status: ${task.status}");
      print("----------");
    } else {
      print("NULL");
    }
    // DBFcts().deleteTask(task.id!);

    return task;
  }
}
