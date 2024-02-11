import 'package:to_do_list/source/model/DBConnectivity.dart';
import 'package:to_do_list/source/model/Task.dart';

class AddNewTask {
  final String title;
  final String? desc;
  final DateTime day;
  final DateTime startTime;
  final DateTime dueTime;
  final int priority;
  final int status;

  AddNewTask(
      {required this.title,
      this.desc,
      required this.day,
      required this.startTime,
      required this.dueTime,
      required this.priority,
      required this.status});

  void createTask() {
    Task newTask = Task(
        title: title,
        description: desc,
        day: day,
        startTime: startTime,
        dueTime: dueTime,
        priority: priority,
        status: status);

    DBFcts().insertIntoDB(newTask);
  }
}
